import 'package:bike_rental_app/models/pass/active_pass.dart';
import 'package:flutter/foundation.dart';
import 'package:bike_rental_app/models/pass/pass.dart';

import 'package:bike_rental_app/ui/states/pass_state.dart';
export 'package:bike_rental_app/ui/states/pass_state.dart';
export 'package:bike_rental_app/models/pass/active_pass.dart';
export 'package:bike_rental_app/models/pass/pass.dart';

class PassViewModel extends ChangeNotifier {
  PassViewModel(this._passState) {
    _passState.addListener(_onPassStateChanged);
  }

  final PassState _passState;

  List<Pass> get availablePlans => _passState.availablePlans;
  String? get errorMessage => _passState.errorMessage;
  ActivePass? get activePass => _passState.activePass;
  Pass? get activePassPlan => _passState.activePassPlan;
  bool get isLoading => _passState.isLoading;
  bool get hasActivePass => activePass != null;

  Future<void> loadPassData() {
    return _passState.loadPassData();
  }

  bool _initialized = false;

  void initialize() {
    if (_initialized) {
      return;
    }

    _initialized = true;
    Future<void>.delayed(Duration.zero, () {
      loadPassData();
    });
  }

  Future<PurchaseResult> purchase(Pass plan, {DateTime? startDate}) {
    return _passState.purchase(plan, startDate: startDate);
  }

  Future<bool> cancelActivePass() {
    return _passState.cancelActivePass();
  }

  Future<void> refreshPassStatus() {
    return _passState.refreshPassStatus();
  }

  void showAvailablePasses() {
    _passState.showAvailablePasses();
  }

  @override
  void dispose() {
    _passState.removeListener(_onPassStateChanged);
    super.dispose();
  }

  void _onPassStateChanged() {
    notifyListeners();
  }
}
