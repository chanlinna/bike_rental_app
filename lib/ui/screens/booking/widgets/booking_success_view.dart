import 'package:bike_rental_app/ui/screens/journey/journey_screen.dart';
import 'package:bike_rental_app/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';

class BookingSuccessView extends StatelessWidget {
  const BookingSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Bike Unlocked!"),
            AppButton(
            label: "Go to Journey",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const JourneyScreen()),
              );
            },
          ),
          ],
        ),
    );
  }
}
