import 'package:bike_rental_app/ui/theme/theme.dart';
import 'package:bike_rental_app/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/booking_view_model.dart';

class BookingTimerView extends StatelessWidget {
  const BookingTimerView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BookingViewModel>();

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
        backgroundColor: AppColors.background,
      ),
      body: SafeArea(
        child: Padding(
          padding: AppSpacings.screenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppButton(
                label: "Unlock Bike",
                isFullWidth: false,
                onTap: () async {
                  await vm.unlockBike();
                },
              ),

              Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 140,
                        height: 140,
                        child: CircularProgressIndicator(
                          value: vm.unlockProgress,
                          strokeWidth: 8,
                          backgroundColor: AppColors.outlineVariant,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        vm.remainingTime,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacings.m),

                  const Text("You have 10 minutes after booking to unlock the bike"),
                ],
              ),

              AppButton(
                label: "Cancel Booking",
                type: AppButtonType.danger,
                onTap: () async {
                  await vm.cancelBooking();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
