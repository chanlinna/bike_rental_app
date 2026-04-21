import 'package:flutter/material.dart';
import '../../../../models/bike/bike.dart';
import '../../../theme/theme.dart';
import '../../booking/booking_screen.dart';

class BikeTile extends StatelessWidget {
  final Bike bike;

  const BikeTile({super.key, required this.bike});

  @override
  Widget build(BuildContext context) {
    final bool isAvailable = bike.bikeStatus == BikeStatus.available;

    return Card(
      margin: const EdgeInsets.only(bottom: AppTextStyles.spaceXS),
      child: ListTile(
        leading: const Icon(Icons.pedal_bike, color: AppColors.primary),
        title: Text("Bike ID: ${bike.bikeId}"),
        subtitle: Text("Status: ${bike.bikeStatus.name}"),
        trailing: ElevatedButton(
          onPressed: isAvailable
              ? () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookingScreen(bikeId: bike.bikeId),
                  ),
                )
              : null,
          child: const Text("Rent"),
        ),
      ),
    );
  }
}
