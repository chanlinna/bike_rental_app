import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../states/map_state.dart';
import './station_list_item.dart';

class AllStationsList extends StatelessWidget {
  const AllStationsList({super.key});

  @override
  Widget build(BuildContext context) {
    final stations = context.watch<MapState>().stations;

    if (stations.isEmpty) {
      return const Center(child: Text("Loading stations..."));
    }

    return ListView.builder(
      itemCount: stations.length,
      itemBuilder: (context, index) {
        return StationListItem(station: stations[index]);
      },
    );
  }
}
