import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bike_rental_app/models/station/station.dart';
import 'package:bike_rental_app/ui/states/map_state.dart';
import 'package:bike_rental_app/ui/states/station_state.dart';
import 'package:bike_rental_app/ui/screens/search/view_model/search_view_model.dart';

class StationListItem extends StatelessWidget {
  final Station station;

  const StationListItem({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    final bool isSelected = context.select<MapState, bool>(
      (map) => map.selectedStation?.stationId == station.stationId,
    );

    final stationState = context.watch<StationState>();

    final liveStation = stationState.allStations.firstWhere(
      (s) => s.stationId == station.stationId,
      orElse: () => station,
    );

    final int displayCount = liveStation.bikeCount;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: displayCount > 0
            ? Colors.green.shade100
            : Colors.red.shade100,
        child: Icon(
          Icons.directions_bike,
          color: displayCount > 0 ? Colors.green : Colors.red,
        ),
      ),
      title: Text(
        liveStation.stationName,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Theme.of(context).primaryColor : Colors.black,
        ),
      ),
      subtitle: Text("$displayCount bikes available"),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        context.read<SearchViewModel>().selectStation(context, liveStation);
      },
    );
  }
}
