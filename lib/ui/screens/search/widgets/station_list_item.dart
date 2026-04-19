import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/station/station.dart';
import '../../../../models/bike/bike.dart'; 
import '../../../states/map_state.dart';
import '../view_model/search_view_model.dart';

class StationListItem extends StatelessWidget {
  final Station station;

  const StationListItem({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    final mapState = context.watch<MapState>();
    final isSelected = mapState.selectedStation?.stationId == station.stationId;

    final updatedStation = mapState.stations.firstWhere(
      (s) => s.stationId == station.stationId,
      orElse: () => station,
    );

    int displayCount;

    if (isSelected && mapState.stationBikes.isNotEmpty) {
      displayCount = mapState.stationBikes
          .where((bike) => bike.bikeStatus == BikeStatus.available)
          .length;
    } else {
      displayCount = updatedStation.bikeCount;
    }

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
      title: Text(updatedStation.stationName),
      subtitle: Text("$displayCount bikes available"),
      trailing: mapState.isBikesLoading && isSelected
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.chevron_right),
      onTap: () {
        context.read<SearchViewModel>().selectStation(context, updatedStation);
        mapState.selectStation(updatedStation);
      },
    );
  }
}
