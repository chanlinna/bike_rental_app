import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/booking_view_model.dart';

class BookingView extends StatelessWidget {
  final String bikeId;

  const BookingView({super.key, required this.bikeId});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<BookingViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Booking")),
      body: Column(
        children: [
          ListTile(title: Text("Bike ID: $bikeId")),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.orange[100],
            child: const Text("Buy a pass to save money"),
          ),

          const Spacer(),

          ElevatedButton(
            onPressed: vm.isLoading ? null : () => vm.confirmBooking(bikeId),

            child: vm.isLoading
                ? const CircularProgressIndicator()
                : const Text("Confirm Booking"),
          ),
        ],
      ),
    );
  }
}
