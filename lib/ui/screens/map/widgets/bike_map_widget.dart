import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../models/station/station.dart'; 
import 'station_info_sheet.dart';

class BikeMapWidget extends StatelessWidget {
  final List<Station> stations;

  const BikeMapWidget({super.key, required this.stations});

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(11.5564, 104.9282), // Phnom Penh
        zoom: 13,
      ),
      markers: stations.map((station) {
        return Marker(
          markerId: MarkerId(station.stationId),
          position: LatLng(station.latitude, station.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            station.bikeCount > 0 ? BitmapDescriptor.hueGreen : BitmapDescriptor.hueRed,
          ),
          onTap: () => _showDetails(context, station),
        );
      }).toSet(),
    );
  }

  void _showDetails(BuildContext context, Station station) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StationInfoSheet(station: station),
    );
  }
}