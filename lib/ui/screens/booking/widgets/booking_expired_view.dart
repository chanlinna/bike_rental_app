import 'package:flutter/material.dart';

class BookingExpiredView extends StatelessWidget {
  const BookingExpiredView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Time is up"),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (r) => r.isFirst);
              },
              child: const Text("Back to Map"),
            ),
          ],
        ),
      ),
    );
  }
}
