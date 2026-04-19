import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../states/map_state.dart';
import 'widgets/bike_map_widget.dart';
import 'widgets/map_search_bar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final state = context.read<MapState>();
      state.fetchStations();
      state.determinePosition();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MapState>();

    return Scaffold(
      body: Stack(
        children: [
          BikeMapWidget(stations: state.filteredStations),

          const SafeArea(
            child: Align(alignment: Alignment.topCenter, child: MapSearchBar()),
          ),

          if (state.isLoading && state.stations.isEmpty)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.blueAccent),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (state.currentLocation != null) {
            state.findNearestStation();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Fetching your location... please wait."),
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
              ),
            );
            state.determinePosition();
          }
        },
        backgroundColor: state.currentLocation != null
            ? Colors.blueAccent
            : Colors.grey.shade400,
        child: state.currentLocation == null && state.isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Icon(Icons.near_me, color: Colors.white),
      ),
    );
  }
}
