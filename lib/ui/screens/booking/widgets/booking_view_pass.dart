import 'package:bike_rental_app/ui/screens/booking/widgets/active_pass_card_statistic.dart';
import 'package:bike_rental_app/ui/screens/pass/view_model/pass_view_model.dart';
import 'package:bike_rental_app/ui/theme/theme.dart';
import 'package:bike_rental_app/ui/widgets/app_button.dart';
import 'package:bike_rental_app/ui/widgets/bike_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/booking_view_model.dart';

class BookingViewPass extends StatelessWidget {
  final String bikeId;

  const BookingViewPass({super.key, required this.bikeId});

  @override
  Widget build(BuildContext context) {
    final bookingVm = context.read<BookingViewModel>();
    final passState = context.watch<PassState>();

    final activePass = passState.activePass;
    final activePlan = passState.activePassPlan;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking"),
        backgroundColor: AppColors.background,
      ),
      body: Padding(
        padding: AppSpacings.screenPadding,
        child: Column(
          children: [
            BikeTile(
              bikeId: bikeId,
              status: "Available",
              type: BikeTileType.info,
            ),

            const SizedBox(height: AppSpacings.m),

            if (activePass != null)
              ActivePassCardStatic(
                activePass: activePass,
                activePlan: activePlan,
                onExpired: () => passState.refreshPassStatus(),
              ),

            const Spacer(),

            AppButton(
              label: "Confirm Booking",
              onTap: bookingVm.isLoading
                  ? null
                  : () => bookingVm.confirmBooking(bikeId),
            ),
          ],
        ),
      ),
    );
  }
}
