import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../models/station/station.dart';
import '../../../states/map_state.dart';
import 'station_info_sheet.dart';

class BikeMapWidget extends StatelessWidget {
  final List<Station> stations;

  const BikeMapWidget({super.key, required this.stations});

  @override
  Widget build(BuildContext context) {
    final mapVM = context.watch<MapState>();
    final selectedStation = mapVM.selectedStation;

    if (selectedStation != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showDetails(context, selectedStation);
      });
    }

    return GoogleMap(
      onMapCreated: (controller) {
        mapVM.onMapCreated(controller);
      },
      initialCameraPosition: const CameraPosition(
        target: LatLng(11.5564, 104.9282), 
        zoom: 13,
      ),
      markers: {
        ...stations.map((station) {
          return Marker(
            markerId: MarkerId(station.stationId),
            position: LatLng(station.latitude, station.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              station.bikeCount > 0
                  ? BitmapDescriptor.hueGreen
                  : BitmapDescriptor.hueRed,
            ),
            onTap: () => mapVM.selectStation(station),
          );
        }),

        if (mapVM.currentLocation != null)
          Marker(
            markerId: const MarkerId('user_label'),
            position: mapVM.currentLocation!,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueAzure,
            ),
            infoWindow: const InfoWindow(
              title: "My Location",
              snippet: "Starting Point",
            ),
          ),
      },
      circles: {
        if (mapVM.currentLocation != null)
          Circle(
            circleId: const CircleId('user_location_circle'),
            center: mapVM.currentLocation!,
            radius: 50, 
            fillColor: Colors.blue.withOpacity(0.3),
            strokeColor: Colors.blueAccent,
            strokeWidth: 2,
            zIndex: 10,
          ),
      },
    );
  }

  void _showDetails(BuildContext context, Station station) {
    if (ModalRoute.of(context)?.isCurrent == false) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StationInfoSheet(station: station),
    ).whenComplete(() {
      context.read<MapState>().clearSelection();
    });
  }
}
