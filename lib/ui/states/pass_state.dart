import 'package:flutter/foundation.dart';
import 'package:bike_rental_app/models/pass/active_pass.dart';
import 'package:bike_rental_app/models/pass/pass.dart';

enum PassViewMode {
	availablePasses,
	activePass,
}

enum PurchaseResult { success, alreadySubscribed }

class PassState extends ChangeNotifier {
	PassState({PassViewMode initialMode = PassViewMode.availablePasses})
		: _mode = initialMode;

	static final List<Pass> availablePlans = <Pass>[
		Pass(passId: 'pass_daily', passType: PassType.daily, price: 15.0),
		Pass(passId: 'pass_weekly', passType: PassType.weekly, price: 60.0),
		Pass(passId: 'pass_monthly', passType: PassType.monthly, price: 120.0),
	];

	PassViewMode _mode;
	ActivePass? _activePass;

	PassViewMode get mode => _mode;


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

		for (final Pass pass in availablePlans) {
			if (pass.passId == current.passId) {
				return pass;
			}
		}

		return null;
	}

  // ========================
  // PURCHASE PASS
  // ========================
	PurchaseResult purchase(Pass plan) {
		if (hasActivePass) {
			return PurchaseResult.alreadySubscribed;
		}

		final DateTime now = DateTime.now();
		_activePass = ActivePass(
			passId: plan.passId,
			startDate: now,
			endDate: now.add(plan.period),
		);
		_mode = PassViewMode.availablePasses;
		notifyListeners();
		return PurchaseResult.success;
	}

  // ========================
  // CREATE PASS
  // ========================
	bool cancelActivePass() {
		if (_activePass == null) {
			return false;
		}

		_activePass = null;
		_mode = PassViewMode.availablePasses;
		notifyListeners();
		return true;
	}

  // ========================
  // CHECK AND REFRESH PASS STATUS
  // ========================
	void refreshPassStatus() {
		final ActivePass? current = _activePass;
		if (current == null) {
			return;
		}

		if (_isExpired(current)) {
			_activePass = null;
			if (_mode == PassViewMode.activePass) {
				_mode = PassViewMode.availablePasses;
			}
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
}
