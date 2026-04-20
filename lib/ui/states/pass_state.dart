import 'package:flutter/foundation.dart';
import 'package:bike_rental_app/models/pass/active_pass.dart';
import 'package:bike_rental_app/models/pass/pass.dart';
import 'package:bike_rental_app/data/repositories/pass/pass_repository.dart';

enum PassViewMode { availablePasses, activePass }

enum PurchaseResult { success, alreadySubscribed, failed }

class PassState extends ChangeNotifier {
  PassState(
    this._passRepository, {
    PassViewMode initialMode = PassViewMode.availablePasses,
  }) : _mode = initialMode;

  final PassRepository _passRepository;
  List<Pass> _availablePlans = <Pass>[];
  bool _isLoading = false;
  String? _errorMessage;

  PassViewMode _mode;
  ActivePass? _activePass;

  PassViewMode get mode => _mode;
  List<Pass> get availablePlans => List<Pass>.unmodifiable(_availablePlans);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  ActivePass? get activePass {
    if (_activePass == null) {
      return null;
    }

    if (_isExpired(_activePass!)) {
      _activePass = null;
      if (_mode == PassViewMode.activePass) {
        _mode = PassViewMode.availablePasses;
      }
      return null;
    }

    return _activePass;
  }

  bool get hasActivePass => activePass != null;

  bool get isAvailablePasses => _mode == PassViewMode.availablePasses;

  bool get isActivePass => _mode == PassViewMode.activePass;

  // ========================
  // ACTIVE PASS
  // ========================
  Pass? get activePassPlan {
    final ActivePass? current = activePass;
    if (current == null) {
      return null;
    }

    for (final Pass pass in _availablePlans) {
      if (pass.passId == current.passId) {
        return pass;
      }
    }

    return null;
  }

  // ========================
  // LOAD PASS DATA
  // ========================
  Future<void> loadPassData() async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final List<Pass> plans = await _passRepository.getAvailablePasses();
      final ActivePass? active = await _passRepository.getActivePass();

      _availablePlans = plans;
      _activePass = active;

      if (_activePass == null && _mode == PassViewMode.activePass) {
        _mode = PassViewMode.availablePasses;
      }
    } catch (_) {
      _errorMessage = 'Unable to load pass data from Firebase.';
    } finally {
      _setLoading(false);
    }
  }

  // ========================
  // PURCHASE PASS
  // ========================
  Future<PurchaseResult> purchase(Pass plan, {DateTime? startDate}) async {
    if (hasActivePass) {
      return PurchaseResult.alreadySubscribed;
    }

    _setLoading(true);
    _errorMessage = null;

    try {
      final ActivePass createdPass = await _passRepository.activatePass(
        passId: plan.passId,
        startDate: startDate,
      );

      _activePass = createdPass;
      _mode = PassViewMode.availablePasses;
      notifyListeners();
      return PurchaseResult.success;
    } catch (e) {
      if (e.toString().contains('already has an active pass')) {
        _activePass = await _passRepository.getActivePass();
        notifyListeners();
        return PurchaseResult.alreadySubscribed;
      }

      _errorMessage = 'Failed to purchase pass. Please try again.';
      notifyListeners();
      return PurchaseResult.failed;
    } finally {
      _setLoading(false);
    }
  }

  // ========================
  // CREATE PASS
  // ========================
  Future<bool> cancelActivePass() async {
    if (_activePass == null) {
      return false;
    }

    _setLoading(true);
    _errorMessage = null;

    try {
      await _passRepository.clearActivePass();
      _activePass = null;
      _mode = PassViewMode.availablePasses;
      notifyListeners();
      return true;
    } catch (_) {
      _errorMessage = 'Failed to cancel active pass. Please try again.';
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // ========================
  // CHECK AND REFRESH PASS STATUS
  // ========================
  Future<void> refreshPassStatus() async {
    _errorMessage = null;

    try {
      final ActivePass? active = await _passRepository.getActivePass();
      _activePass = active;

      if (_activePass == null && _mode == PassViewMode.activePass) {
        _mode = PassViewMode.availablePasses;
      }

      notifyListeners();
    } catch (_) {
      _errorMessage = 'Failed to refresh pass status.';
      notifyListeners();
    }
  }

  // ==========================================
  // SET MODE  - AVAILABLE / ACTIVE
  // ==========================================
  void setMode(PassViewMode mode) {
    if (_mode == mode) {
      return;
    }

    _mode = mode;
    notifyListeners();
  }

  // ========================
  // SHOW AVAILABLE PASSES
  // ========================
  void showAvailablePasses() {
    setMode(PassViewMode.availablePasses);
  }

  // ========================
  // SHOW ACTIVE PASS
  // ========================
  void showActivePass() {
    setMode(PassViewMode.activePass);
  }

  // ========================
  // EXPIRED THE PASS
  // ========================
  bool _isExpired(ActivePass pass) {
    return DateTime.now().isAfter(pass.endDate);
  }

  void _setLoading(bool value) {
    if (_isLoading == value) {
      return;
    }

    _isLoading = value;
    notifyListeners();
  }
}
