import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/booking_view_model.dart';

import 'booking_view.dart';
import 'booking_timer_view.dart';
import 'booking_success_view.dart';
import 'booking_expired_view.dart';

class BookingContent extends StatelessWidget {
  final String bikeId;

  const BookingContent({super.key, required this.bikeId});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BookingViewModel>();

    if (!vm.hasBooking) {
      return BookingView(bikeId: bikeId);
    }

    if (vm.isExpired) {
      return const BookingExpiredView();
    }

    if (vm.isReserved) {
      return const BookingTimerView();
    }

    if (vm.isActive) {
      return const BookingSuccessView();
    }

    return const SizedBox();
  }
}
