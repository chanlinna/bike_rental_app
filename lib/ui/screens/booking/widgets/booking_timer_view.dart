import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/booking_view_model.dart';

class BookingTimerView extends StatelessWidget {
  const BookingTimerView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BookingViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Unlock Bike")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(vm.remainingTime, style: const TextStyle(fontSize: 40)),
          const Text("You have 10 minutes to unlock"),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: vm.unlockBike,
            child: const Text("Unlock Bike"),
          ),

          TextButton(
            onPressed: vm.cancelBooking,
            child: const Text("Cancel", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
