import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/station/station.dart';
import '../../../../models/bike/bike.dart'; 
import '../../../states/map_state.dart';
import '../../../theme/theme.dart';

class StationInfoSheet extends StatelessWidget {
  final Station station;

  const StationInfoSheet({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.watch<MapState>();

    final realAvailableCount = state.stationBikes
        .where((bike) => bike.bikeStatus == BikeStatus.available)
        .length;

    final bool hasFetchedBikes =
        state.stationBikes.isNotEmpty || !state.isBikesLoading;
    final displayCount = hasFetchedBikes
        ? realAvailableCount
        : station.bikeCount;

    return Container(
      padding: const EdgeInsets.all(AppTextStyles.spaceM),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            station.stationName,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppTextStyles.spaceXS),
          Row(
            children: [
              Icon(
                Icons.pedal_bike,
                size: 20,
                color: theme.colorScheme.secondary,
              ),
              const SizedBox(width: AppTextStyles.spaceXS),
              state.isBikesLoading
                  ? const SizedBox(
                      height: 10,
                      width: 10,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text('$displayCount bikes available'),
            ],
          ),
          const SizedBox(height: AppTextStyles.spaceL),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: displayCount > 0
                  ? () => Navigator.pushNamed(
                      context,
                      '/bikes',
                      arguments: station,
                    )
                  : null,
              child: Text(
                displayCount > 0
                    ? 'View Available Bikes'
                    : 'No Bikes Available',
              ),
            ),
          ),
          const SizedBox(height: AppTextStyles.spaceM),
        ],
      ),
    );
  }
}
