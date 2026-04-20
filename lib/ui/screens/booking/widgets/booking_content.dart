import 'package:bike_rental_app/ui/screens/booking/widgets/booking_view_pass.dart';
import 'package:bike_rental_app/ui/states/pass_state.dart';
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
    final passState = context.watch<PassState>();

    if (vm.isExpired) {
      return const BookingExpiredView();
    }

    if (!vm.hasBooking) {
      if (passState.hasActivePass) {
        return BookingViewPass(bikeId: bikeId);
      } else {
        return BookingView(bikeId: bikeId);
      }
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
