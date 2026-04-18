import 'package:flutter/material.dart';
import '../../../../models/station/station.dart';
import '../../../theme/theme.dart';
import '../bike_list_screen.dart'; 

class StationInfoSheet extends StatelessWidget {
  final Station station;

  const StationInfoSheet({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppTextStyles.spaceM),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(station.stationName, style: theme.textTheme.headlineSmall),
          const SizedBox(height: AppTextStyles.spaceXS),
          Row(
            children: [
              Icon(Icons.pedal_bike, size: 20, color: theme.colorScheme.secondary),
              const SizedBox(width: AppTextStyles.spaceXS),
              Text('${station.bikeCount} bikes available'),
            ],
          ),
          const SizedBox(height: AppTextStyles.spaceL),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: station.bikeCount > 0 ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BikeListScreen(station: station),
                  ),
                );
              } : null,
              child: const Text('View Available Bikes'),
            ),
          ),
        ],
      ),
    );
  }
}