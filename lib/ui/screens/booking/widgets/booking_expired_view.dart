import 'package:bike_rental_app/ui/states/booking_state.dart';
import 'package:bike_rental_app/ui/theme/theme.dart';
import 'package:bike_rental_app/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingExpiredView extends StatelessWidget {
  const BookingExpiredView({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingState = context.read<BookingState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w800,
            height: 1.1,
          ).copyWith(color: AppColors.secondary),
        ),
        automaticallyImplyLeading: false,
        leading: null,
        backgroundColor: AppColors.background,
      ),
      body: Container(
        padding: AppSpacings.screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.access_time_filled,
                      size: 180,
                      color: AppColors.error,
                    ),
                    Text(
                      "Time is Up",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "Your booking has been automatically cancelled.",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),

            AppButton(
              label: "Back to Map",
              onTap: () {
                bookingState.clearBooking();
                Navigator.popUntil(context, (r) => r.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }
}
