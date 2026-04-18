import 'package:flutter/material.dart';
import '../../../../models/station/station.dart';
import './station_list_item.dart';

class SearchResultsList extends StatelessWidget {
  final List<Station> results;

  const SearchResultsList({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text("No stations match your search."),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return StationListItem(station: results[index]);
      },
    );
  }
}
