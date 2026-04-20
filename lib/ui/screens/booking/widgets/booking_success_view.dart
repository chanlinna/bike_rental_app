import 'package:bike_rental_app/ui/screens/journey/journey_screen.dart';
import 'package:bike_rental_app/ui/theme/theme.dart';
import 'package:bike_rental_app/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';

class BookingSuccessView extends StatelessWidget {
  const BookingSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
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
                        const Icon(Icons.directions_bike, size: 160, color: AppColors.primary),
                        Text(
                          "Successfully unlock the bike",
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                ),
                AppButton(
                label: "Go to current Journey",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const JourneyScreen()),
                  );
                },
              ),
            ]
        ),
      ),
    );
  }
}
