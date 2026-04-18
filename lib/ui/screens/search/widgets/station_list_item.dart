import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/station/station.dart';
import '../view_model/search_view_model.dart';

class StationListItem extends StatelessWidget {
  final Station station;

  const StationListItem({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.directions_bike)),
      title: Text(station.stationName),
      subtitle: Text("${station.bikeCount} bikes available"),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        context.read<SearchViewModel>().selectStation(context, station);
      },
    );
  }
}
