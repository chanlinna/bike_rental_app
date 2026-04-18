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
    Future.microtask(() => context.read<MapState>().fetchStations());
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MapState>();

    return Scaffold(
      body: Stack(
        children: [
          BikeMapWidget(stations: state.filteredStations),

          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: MapSearchBar(),
            ),
          ),

          if (state.isLoading && state.stations.isEmpty)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}