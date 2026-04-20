import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../states/station_state.dart'; 
import 'view_model/search_view_model.dart';
import './widgets/all_stations_list.dart';
import './widgets/search_results_list.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchVM = context.watch<SearchViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Hero(
          tag: 'search_bar',
          child: Material(
            type: MaterialType.transparency,
            child: TextField(
              autofocus: true,
              style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                hintText: "Enter station name...",
                border: InputBorder.none,
                hintStyle: const TextStyle(color: Colors.grey),
                suffixIcon: searchVM.query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () => searchVM.updateQuery(""),
                      )
                    : null,
              ),
              onChanged: (value) => searchVM.updateQuery(value),
            ),
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _buildSearchContent(context, searchVM),
      ),
    );
  }

  Widget _buildSearchContent(BuildContext context, SearchViewModel searchVM) {
    final stationState = context.watch<StationState>();

    final stations = searchVM.getFilteredStations(stationState.allStations);

    if (searchVM.mode == SearchMode.allStations) {
      return AllStationsList(
        key: const ValueKey('all_stations'),
        stations: stations,
      );
    }

    return SearchResultsList(
      key: const ValueKey('search_results'),
      results: stations,
    );
  }
}
