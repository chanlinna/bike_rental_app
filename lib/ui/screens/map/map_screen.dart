import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../states/station_state.dart'; 
import '../../states/map_state.dart';
import 'widgets/bike_map_widget.dart';
import 'widgets/map_search_bar.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          MapState(context.read()),
      child: Consumer2<StationState, MapState>(
        builder: (context, stationState, mapVM, child) {
          if (stationState.allStations.isEmpty && !stationState.isLoading) {
            Future.microtask(() => stationState.fetchStations());
          }
          return Scaffold(
            body: Stack(
              children: [
                // Use stationState for the data
                BikeMapWidget(stations: stationState.allStations),

                const SafeArea(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: MapSearchBar(),
                  ),
                ),

                if (stationState.isLoading && stationState.allStations.isEmpty)
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (mapVM.currentLocation != null) {
                  mapVM.findNearestStation(stationState.allStations);
                } else {
                  mapVM.determinePosition();
                }
              },
              backgroundColor: mapVM.currentLocation != null
                  ? Colors.blueAccent
                  : Colors.grey,
              child: const Icon(Icons.near_me, color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
