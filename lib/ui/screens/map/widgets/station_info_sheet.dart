import 'package:bike_rental_app/ui/screens/bike/bike_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import '../../../../models/station/station.dart';
import '../../../states/map_state.dart'; 
import '../../../theme/theme.dart';

class StationInfoSheet extends StatelessWidget {
  final Station station;

  const StationInfoSheet({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final state = context.watch<MapState>();
    

    final currentStation = (state.selectedStation?.stationId == station.stationId)
        ? state.selectedStation!
        : station;

    return Container(
      padding: const EdgeInsets.all(AppTextStyles.spaceM),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currentStation.stationName,
            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppTextStyles.spaceXS),
          Row(
            children: [
              Icon(Icons.pedal_bike, size: 20, color: theme.colorScheme.secondary),
              const SizedBox(width: AppTextStyles.spaceXS),
              // Shows a loading indicator or the actual count
              state.isBikesLoading 
                ? const SizedBox(height: 10, width: 10, child: CircularProgressIndicator(strokeWidth: 2))
                : Text('${currentStation.bikeCount} bikes available'),
            ],
          ),
          const SizedBox(height: AppTextStyles.spaceL),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: currentStation.bikeCount > 0
                  ? () {
                     Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BikeListScreen(station: currentStation),
                        ),
                      );
                    }
                  : null,
              child: const Text('View Available Bikes'),
            ),
          ),
          const SizedBox(height: AppTextStyles.spaceM),
        ],
      ),
    );
  }
}