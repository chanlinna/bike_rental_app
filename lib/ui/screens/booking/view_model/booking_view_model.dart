import 'package:flutter/material.dart';
import '../../../states/booking_state.dart';
import '../../../../models/booking/booking.dart';

class BookingViewModel extends ChangeNotifier {
  final BookingState _state;

  BookingViewModel(this._state) {
    _state.addListener(notifyListeners);
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Booking? get booking => _state.currentBooking;

  bool get hasBooking => booking != null;
  bool get isReserved => booking?.bookingStatus == BookingStatus.reserved;
  bool get isActive => booking?.bookingStatus == BookingStatus.active;
  bool get isExpired => _state.wasExpired;

  String get remainingTime {
    final m = _state.remainingSeconds ~/ 60;
    final s = _state.remainingSeconds % 60;
    return "$m:${s.toString().padLeft(2, '0')}";
  }

  Future<void> confirmBooking(String bikeId) async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      await _state.createBooking(bikeId);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> cancelBooking() async {
    await _state.cancelBooking();
  }

  Future<void> unlockBike() async {
    await _state.unlockBike();
  }

  @override
  void dispose() {
    _state.removeListener(notifyListeners);
    super.dispose();
  }
}
