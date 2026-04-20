import 'package:flutter/material.dart';
import '../../../states/booking_state.dart';

class JourneyViewModel extends ChangeNotifier {
  final BookingState _state;

  JourneyViewModel(this._state) {
    _state.addListener(notifyListeners);
  }

  bool get hasActiveJourney => _state.isRiding;
  bool get isFinished => _state.isFinished;

  Duration get duration => _state.journeyDuration;

  String get formattedTime {
    final m = duration.inMinutes;
    final s = duration.inSeconds % 60;
    return "$m:${s.toString().padLeft(2, '0')}";
  }

  double get price => _state.price;

  Future<void> endJourney() async {
    await _state.endJourney();
  }

  void clear() {
    _state.clearBooking();
  }

  @override
  void dispose() {
    _state.removeListener(notifyListeners);
    super.dispose();
  }
}
