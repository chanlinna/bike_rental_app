import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/station/station.dart';
import '../../../states/map_state.dart'; 

enum SearchMode { allStations, searchResults }

class SearchViewModel extends ChangeNotifier {
  String _query = "";
  SearchMode _mode = SearchMode.allStations;

  String get query => _query;
  SearchMode get mode => _mode;

  void updateQuery(String newQuery) {
    _query = newQuery;
    _mode = _query.isEmpty ? SearchMode.allStations : SearchMode.searchResults;
    notifyListeners();
  }

  List<Station> getFilteredStations(List<Station> allStations) {
    if (_mode == SearchMode.allStations) return allStations;

    return allStations
        .where(
          (s) => s.stationName.toLowerCase().contains(_query.toLowerCase()),
        )
        .toList();
  }

  void selectStation(BuildContext context, Station station) {
    context.read<MapState>().selectStation(station);

    Navigator.pushNamed(
      context,
      '/bikes',
      arguments: station, 
    );
  }
}
