import 'package:flutter/material.dart';
import 'package:bike_rental_app/models/station/station.dart';
import 'package:bike_rental_app/ui/states/map_state.dart';

enum SearchMode { allStations, searchResults }

class SearchViewModel extends ChangeNotifier {
  final MapState _mapState;
  String _query = "";
  SearchMode _mode = SearchMode.allStations;

  SearchViewModel(this._mapState);

  String get query => _query;
  SearchMode get mode => _mode;

  void updateQuery(String newQuery) {
    _query = newQuery;
    _mode = _query.isEmpty ? SearchMode.allStations : SearchMode.searchResults;
    notifyListeners();
  }

  List<Station> getFilteredStations(List<Station> allStations) {
    if (_query.isEmpty) return allStations;

    return allStations
        .where(
          (s) => s.stationName.toLowerCase().contains(_query.toLowerCase()),
        )
        .toList();
  }

  void selectStation(BuildContext context, Station station) {
    _mapState.selectStation(station);

    Navigator.pushNamed(context, '/bikes', arguments: station);
  }
}
