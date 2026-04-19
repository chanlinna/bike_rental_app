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
    final selectedStation = context.watch<MapState>().selectedStation;

    if (selectedStation != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showDetails(context, selectedStation);
      });
    }

    return GoogleMap(
      onMapCreated: (controller) {
        context.read<MapState>().onMapCreated(controller);
      },
      initialCameraPosition: const CameraPosition(
        target: LatLng(11.5564, 104.9282),
        zoom: 13,
      ),
      markers: stations.map((station) {
        return Marker(
          markerId: MarkerId(station.stationId),
          position: LatLng(station.latitude, station.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            station.bikeCount > 0
                ? BitmapDescriptor.hueGreen
                : BitmapDescriptor.hueRed,
          ),

          onTap: () => context.read<MapState>().selectStation(station),
        );
      }).toSet(),
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
      context.read<MapState>().clearSelectedStation();
    });
  }
}
