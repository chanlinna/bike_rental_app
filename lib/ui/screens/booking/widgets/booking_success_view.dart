import 'package:flutter/material.dart';

class BookingSuccessView extends StatelessWidget {
  const BookingSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Bike Unlocked!"),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/journey');
              },
              child: const Text("Go to Journey"),
            ),
          ],
        ),
      ),
    );
  }
}
