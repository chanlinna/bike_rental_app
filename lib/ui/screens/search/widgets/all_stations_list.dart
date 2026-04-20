import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../states/station_state.dart';
import './station_list_item.dart';

class AllStationsList extends StatelessWidget {
  const AllStationsList({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLoading = context.select<StationState, bool>(
      (s) => s.isLoading,
    );
    final int stationCount = context.select<StationState, int>(
      (s) => s.allStations.length,
    );

    final stations = context.read<StationState>().allStations;

    if (isLoading && stations.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (stations.isEmpty) {
      return const Center(child: Text("No stations found."));
    }

    return ListView.builder(
      itemCount: stations.length,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, index) {
        return StationListItem(station: stations[index]);
      },
    );
  }
}
