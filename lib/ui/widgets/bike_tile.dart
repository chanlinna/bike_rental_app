import 'package:bike_rental_app/ui/theme/theme.dart';
import 'package:flutter/material.dart';

enum BikeTileType { rent, unlock, info }

class BikeTile extends StatelessWidget {
  final String bikeId;
  final String status;
  final BikeTileType type;
  final VoidCallback? onRent;
  final VoidCallback? onUnlock;

  const BikeTile({
    super.key,
    required this.bikeId,
    required this.status,
    required this.type,
    this.onRent,
    this.onUnlock,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppTextStyles.spaceXS),
      child: ListTile(
        leading: const Icon(Icons.pedal_bike, color: AppColors.primary),
        title: Text("Bike ID: $bikeId"),
        subtitle: Text("Status: $status"),
        trailing: _buildTrailing(),
      ),
    );
  }

  Widget? _buildTrailing() {
    switch (type) {
      case BikeTileType.rent:
        return ElevatedButton(onPressed: onRent, child: const Text("Rent"));
      case BikeTileType.unlock:
        return ElevatedButton(onPressed: onUnlock, child: const Text("Unlock"));
      case BikeTileType.info:
        return null; // no button
    }
  }
}
