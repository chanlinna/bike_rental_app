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
        title: const Text("Booking"),
        backgroundColor: AppColors.background,
      ),
      body: Container(
        padding: AppSpacings.screenPadding,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppButton(
                label: "Unlock Bike",
                onTap: () async {
                  await vm.unlockBike();
                },
                isFullWidth: false,
              ),

              Column(
                children: [
                  Text(vm.remainingTime, style: const TextStyle(fontSize: 40)),
                  const Text("You have 10 minutes to unlock the bike"),
                ],
              ),
        
              AppButton(label: "Cancel Booking", type: AppButtonType.danger,
                onTap: () async {
                  await vm.cancelBooking();
                },
              )
            ],
        ),
      ),
    );
  }
}
