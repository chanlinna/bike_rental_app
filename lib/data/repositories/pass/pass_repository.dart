import 'package:bike_rental_app/models/pass/pass.dart';
import 'package:bike_rental_app/models/pass/active_pass.dart';
import 'package:bike_rental_app/data/repositories/pass/repository.dart' as pass_contract;


class PassRepository implements pass_contract.PassRepository {
  PassRepository({List<Pass>? availablePasses})
    : _availablePasses = availablePasses ?? _defaultPasses;

  static final List<Pass> _defaultPasses = [
    Pass(passId: 'pass_daily', passType: PassType.daily, price: 1.5),
    Pass(passId: 'pass_weekly', passType: PassType.weekly, price: 8.0),
    Pass(passId: 'pass_monthly', passType: PassType.monthly, price: 25.0),
  ];

  final List<Pass> _availablePasses;
  ActivePass? _activePass;

  @override
  Future<List<Pass>> getAvailablePasses() async {
    return List<Pass>.unmodifiable(_availablePasses);
  }

  @override
  Future<ActivePass?> getActivePass() async {
    return _getCurrentActivePass();
  }

  @override
  Future<ActivePass> activatePass({
    required String passId,
    DateTime? startDate,
  }) async {
    if (_getCurrentActivePass() != null) {
      throw Exception('User already has an active pass');
    }

    final pass = _availablePasses.firstWhere(
      (item) => item.passId == passId,
      orElse: () => throw StateError('Pass with id "$passId" not found.'),
    );

    final start = startDate ?? DateTime.now();
    final end = _calculateEndDate(start, pass.passType);

    final activePass = ActivePass(
      passId: pass.passId,
      startDate: start,
      endDate: end,
    );

    _activePass = activePass;

    return activePass;
  }

  @override
  Future<void> clearActivePass() async {
    _activePass = null;
  }

  @override
  Future<List<ActivePass>> getPassHistory() async {
    final ActivePass? activePass = _getCurrentActivePass();
    return activePass == null ? <ActivePass>[] : <ActivePass>[activePass];
  }

  @override
  Future<bool> canActivatePass() async {
    return _getCurrentActivePass() == null;
  }

  DateTime _calculateEndDate(DateTime startDate, PassType passType) {
    switch (passType) {
      case PassType.daily:
        return startDate.add(const Duration(days: 1));
      case PassType.weekly:
        return startDate.add(const Duration(days: 7));
      case PassType.monthly:
        return DateTime(startDate.year, startDate.month + 1, startDate.day);
    }
  }

  ActivePass? _getCurrentActivePass() {
    final ActivePass? activePass = _activePass;

    if (activePass == null) {
      return null;
    }

    if (_isActivePassExpired(activePass)) {
      _activePass = null;
      return null;
    }

    return activePass;
  }

  bool _isActivePassExpired(ActivePass activePass) {
    return !activePass.endDate.isAfter(DateTime.now());
  }
}
