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
    List<Station> filtered = _query.isEmpty
        ? List.from(
            allStations,
          ) 
        : allStations
              .where(
                (s) =>
                    s.stationName.toLowerCase().contains(_query.toLowerCase()),
              )
              .toList();

    // Move zero bike stations to the end
    filtered.sort((a, b) {
      if (a.bikeCount > 0 && b.bikeCount == 0) return -1;
      if (a.bikeCount == 0 && b.bikeCount > 0) return 1;

      // Otherwise, alphabetical order by name
      return a.stationName.compareTo(b.stationName);
    });

    return filtered;
  }

  void selectStation(BuildContext context, Station station) {
    _mapState.selectStation(station);

    Navigator.pushNamed(context, '/bikes', arguments: station);
  }
}
