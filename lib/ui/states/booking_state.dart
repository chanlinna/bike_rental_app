import 'dart:async';
import 'package:bike_rental_app/data/repositories/booking/booking_repository.dart';
import 'package:flutter/material.dart';

import '../../models/booking/booking.dart';

class BookingState extends ChangeNotifier {
  final BookingRepository _repo;

  Booking? _currentBooking;

  Timer? _bookingTimer;
  Timer? _journeyTimer;

  int _remainingSeconds = 600;
  Duration _journeyDuration = Duration.zero;

  BookingState(this._repo);

  bool _wasExpired = false;
  bool get wasExpired => _wasExpired;

  Booking? get currentBooking => _currentBooking;
  int get remainingSeconds => _remainingSeconds;
  Duration get journeyDuration => _journeyDuration;

  bool get isExpired => _remainingSeconds <= 0;
  bool get isRiding => _currentBooking?.bookingStatus == BookingStatus.active;
  bool get isFinished => _currentBooking?.bookingStatus == BookingStatus.completed;

  double get price {
    if (_currentBooking == null || _currentBooking!.startTime == null) {
      return 0;
    }

    final minutes = _journeyDuration.inMinutes;

    // Free first 2 minutes
    if (minutes <= 2) return 0;

    final chargeableMinutes = minutes - 2;

    final blocks = (chargeableMinutes / 5).ceil();

    return blocks * 0.25;
  }

  Future<void> createBooking(String bikeId) async {
    _wasExpired = false;
    final booking = await _repo.createBooking(bikeId: bikeId);

    _currentBooking = booking;

    await _repo.markBikeAsBooked(bikeId);

    _startBookingTimer();

    notifyListeners();
  }

  void _startBookingTimer() {
    _bookingTimer?.cancel();

    _remainingSeconds = 600;

    _bookingTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _remainingSeconds--;

      if (_remainingSeconds <= 0) {
        expireBooking();
      }

      notifyListeners();
    });
  }

  Future<void> expireBooking() async {
    _wasExpired = true;
    if (_currentBooking == null) return;

    final expired = Booking(
      bookingId: _currentBooking!.bookingId,
      bikeId: _currentBooking!.bikeId,
      reservedAt: _currentBooking!.reservedAt,
      bookingStatus: BookingStatus.cancelled,
    );

    await _repo.updateBooking(expired);
    await _repo.markBikeAsAvailable(expired.bikeId);

    _currentBooking = null;

    _bookingTimer?.cancel();

    notifyListeners();
  }

  Future<void> cancelBooking() async {
    if (_currentBooking == null) return;

    final cancelled = Booking(
      bookingId: _currentBooking!.bookingId,
      bikeId: _currentBooking!.bikeId,
      reservedAt: _currentBooking!.reservedAt,
      bookingStatus: BookingStatus.cancelled,
    );

    await _repo.updateBooking(cancelled);
    await _repo.markBikeAsAvailable(cancelled.bikeId);

    _currentBooking = null;
    _bookingTimer?.cancel();

    notifyListeners();
  }

  Future<void> unlockBike() async {
    if (_currentBooking == null) return;

    final updated = Booking(
      bookingId: _currentBooking!.bookingId,
      bikeId: _currentBooking!.bikeId,
      reservedAt: _currentBooking!.reservedAt,
      startTime: DateTime.now(),
      bookingStatus: BookingStatus.active,
    );

    _currentBooking = updated;

    await _repo.updateBooking(updated);

    _bookingTimer?.cancel();
    _startJourneyTimer();

    notifyListeners();
  }

  void _startJourneyTimer() {
    _journeyTimer?.cancel();

    _journeyTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_currentBooking?.startTime != null) {
        _journeyDuration = DateTime.now().difference(
          _currentBooking!.startTime!,
        );

        notifyListeners();
      }
    });
  }

  Future<void> endJourney() async {
    if (_currentBooking == null) return;

    final updated = Booking(
      bookingId: _currentBooking!.bookingId,
      bikeId: _currentBooking!.bikeId,
      reservedAt: _currentBooking!.reservedAt,
      startTime: _currentBooking!.startTime,
      endTime: DateTime.now(),
      bookingStatus: BookingStatus.completed,
    );

    _currentBooking = updated;

    await _repo.updateBooking(updated);
    await _repo.markBikeAsAvailable(updated.bikeId);

    _journeyTimer?.cancel();

    notifyListeners();
  }

  void clearBooking() {
    _currentBooking = null;
    _journeyDuration = Duration.zero;
    _remainingSeconds = 600;

    _bookingTimer?.cancel();
    _journeyTimer?.cancel();

    notifyListeners();
  }
}
