import 'package:flutter/foundation.dart';

enum PassViewMode {
	availablePasses,
	activePass,
}

enum PurchaseResult {
	success,
	alreadyHasActivePass,
}

class PassPlan {
	const PassPlan({
		required this.name,
		required this.price,
		required this.durationLabel,
		required this.validity,
	});

	final String name;
	final String price;
	final String durationLabel;
	final Duration validity;
}

class ActivePass {
	const ActivePass({
		required this.plan,
		required this.purchasedAt,
		required this.expiresAt,
	});

	final PassPlan plan;
	final DateTime purchasedAt;
	final DateTime expiresAt;
}

class PassViewModel extends ChangeNotifier {
	PassViewModel({PassViewMode initialMode = PassViewMode.availablePasses})
		: _mode = initialMode;

	PassViewMode _mode;
	ActivePass? _activePass;

	static const List<PassPlan> availablePlans = <PassPlan>[
		PassPlan(
			name: 'Daily Pass',
			price: r'$ 15.00',
			durationLabel: '24 hours',
			validity: Duration(hours: 24),
		),
		PassPlan(
			name: 'Weekly Pass',
			price: r'$ 60.00',
			durationLabel: '7 days',
			validity: Duration(days: 7),
		),
		PassPlan(
			name: 'Monthly Pass',
			price: r'$ 120.00',
			durationLabel: '30 days',
			validity: Duration(days: 30),
		),
	];

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

	bool get isShowingAvailablePasses => _mode == PassViewMode.availablePasses;

	bool get isShowingActivePass => _mode == PassViewMode.activePass;

	PurchaseResult purchase(PassPlan plan) {
		if (hasActivePass) {
			return PurchaseResult.alreadyHasActivePass;
		}

		final DateTime now = DateTime.now();
		_activePass = ActivePass(
			plan: plan,
			purchasedAt: now,
			expiresAt: now.add(plan.validity),
		);
		_mode = PassViewMode.availablePasses;
		notifyListeners();
		return PurchaseResult.success;
	}

	bool cancelActivePass() {
		if (_activePass == null) {
			return false;
		}

		_activePass = null;
		_mode = PassViewMode.availablePasses;
		notifyListeners();
		return true;
	}

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

	void setMode(PassViewMode mode) {
		if (_mode == mode) {
			return;
		}

		_mode = mode;
		notifyListeners();
	}

	void showAvailablePasses() {
		setMode(PassViewMode.availablePasses);
	}

	void showActivePass() {
		setMode(PassViewMode.activePass);
	}

	bool _isExpired(ActivePass pass) {
		return DateTime.now().isAfter(pass.expiresAt);
	}
}
