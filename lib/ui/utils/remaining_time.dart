import 'dart:async';

import 'package:bike_rental_app/ui/utils/pass_time.dart';
import 'package:flutter/material.dart';


class RemainingTime extends StatefulWidget {
	const RemainingTime({
		super.key,
		required this.expiresAt,
		required this.style,
		this.onExpired,
	});

	final DateTime expiresAt;
	final TextStyle style;
	final VoidCallback? onExpired;

	@override
	State<RemainingTime> createState() => _RemainingTimeState();
}

class _RemainingTimeState extends State<RemainingTime> {
	late Duration _remaining;
	Timer? _ticker;
	bool _didNotifyExpired = false;

	@override
	void initState() {
		super.initState();
		_remaining = widget.expiresAt.difference(DateTime.now());
		_ticker = Timer.periodic(const Duration(seconds: 1), (_) {
			if (!mounted) {
				return;
			}

			setState(() {
				_remaining = widget.expiresAt.difference(DateTime.now());
			});

			if (_remaining.inSeconds <= 0 && !_didNotifyExpired) {
				_didNotifyExpired = true;
				widget.onExpired?.call();
			}
		});
	}

	@override
	void didUpdateWidget(covariant RemainingTime oldWidget) {
		super.didUpdateWidget(oldWidget);
		if (oldWidget.expiresAt != widget.expiresAt) {
			_remaining = widget.expiresAt.difference(DateTime.now());
			_didNotifyExpired = false;
		}
	}

	@override
	void dispose() {
		_ticker?.cancel();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Text(
			PassTime.formatRemaining(_remaining),
			style: widget.style,
		);
	}
}
