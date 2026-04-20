import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/station/station.dart';
import '../../../states/station_state.dart'; 
import '../../../theme/theme.dart';

class StationInfoSheet extends StatelessWidget {
  final Station station;

  const StationInfoSheet({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final stationState = context.watch<StationState>();

    final liveStation = stationState.allStations.firstWhere(
      (s) => s.stationId == station.stationId,
      orElse: () => station,
    );

    final displayCount = liveStation.bikeCount;

    return Container(
      padding: const EdgeInsets.all(AppTextStyles.spaceM),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            liveStation.stationName,
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
              stationState.isLoading && stationState.allStations.isEmpty
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
                      arguments: liveStation,
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
