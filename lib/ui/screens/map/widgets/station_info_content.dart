import 'package:flutter/material.dart';
import '../../../../models/station/station.dart';
import '../../../theme/theme.dart';

class StationInfoContent extends StatelessWidget {
  final Station station;
  final bool isLoading;
  final VoidCallback? onViewBikes;

  const StationInfoContent({
    super.key,
    required this.station,
    required this.isLoading,
    this.onViewBikes,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayCount = station.bikeCount;

    return Column(
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
            isLoading
                ? const SizedBox(
                    width: 10,
                    height: 10,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text('$displayCount bikes available'),
          ],
        ),
        const SizedBox(height: AppTextStyles.spaceL),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: displayCount > 0 ? onViewBikes : null,
            child: Text(
              displayCount > 0 ? 'View Available Bikes' : 'No Bikes Available',
            ),
          ),
        ),
        const SizedBox(height: AppTextStyles.spaceM),
      ],
    );
  }
}
