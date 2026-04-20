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

	static List<Pass> get availablePlans => PassState.availablePlans;

	PassViewMode get mode => _passState.mode;

	ActivePass? get activePass => _passState.activePass;

	Pass? get activePassPlan => _passState.activePassPlan;

	bool get hasActivePass => activePass != null;

	bool get isAvailablePasses => _passState.isAvailablePasses;

	bool get isActivePass => _passState.isActivePass;

	PurchaseResult purchase(Pass plan) {
		return _passState.purchase(plan);
	}

	bool cancelActivePass() {
		return _passState.cancelActivePass();
	}

	void refreshPassStatus() {
		_passState.refreshPassStatus();
	}

	void setMode(PassViewMode mode) {
		_passState.setMode(mode);
	}

	void showAvailablePasses() {
		_passState.showAvailablePasses();
	}

	void showActivePass() {
		_passState.showActivePass();
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
