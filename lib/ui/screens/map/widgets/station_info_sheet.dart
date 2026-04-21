import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/station/station.dart';
import '../../../states/station_state.dart';
import '../../../theme/theme.dart';
import 'station_info_content.dart'; 

class StationInfoSheet extends StatelessWidget {
  final Station station;

  const StationInfoSheet({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    final stationState = context.watch<StationState>();

    final liveStation = stationState.getLiveStation(station.stationId, station);

    return Container(
      padding: const EdgeInsets.all(AppTextStyles.spaceM),
      child: StationInfoContent(
        station: liveStation,
        isLoading: stationState.isLoading && stationState.allStations.isEmpty,
        onViewBikes: () =>
            Navigator.pushNamed(context, '/bikes', arguments: liveStation),
      ),
    );
  }
}
