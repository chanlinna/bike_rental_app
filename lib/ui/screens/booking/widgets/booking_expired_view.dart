import 'package:bike_rental_app/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';

class BookingExpiredView extends StatelessWidget {
  const BookingExpiredView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Time is up"),
            AppButton(
            label: "Back to Map",
            onTap: () {
              Navigator.popUntil(context, (r) => r.isFirst);
            },
          ),
          ],
        ),
    );
  }
}
