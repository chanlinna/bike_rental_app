import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../models/station/station.dart';
import '../utils/location_utils.dart';
import '../../data/repositories/bike_repository.dart';
import '../utils/marker_generator.dart';

class MapState extends ChangeNotifier {
  final BikeRepository _bikeRepository;

  GoogleMapController? _mapController;
  LatLng? _currentLocation;
  Station? _selectedStation;

  MapState(this._bikeRepository) {
    determinePosition();
  }

  LatLng? get currentLocation => _currentLocation;
  Station? get selectedStation => _selectedStation;
  GoogleMapController? get mapController => _mapController;

  Map<String, BitmapDescriptor> stationIcons = {};
  String _lastDataHash = "";

  Future<void> prepareStationIcons(
    List<Station> stations, {
    double scale = 1.0,
  }) async {
    final String currentHash =
        stations.map((s) => "${s.stationId}:${s.bikeCount}").join(",") +
        "|scale:$scale";

    if (_lastDataHash == currentHash && stationIcons.isNotEmpty) return;

    final double targetSize = 60.0 * scale;

    for (var station in stations) {
      final color = station.bikeCount > 0 ? Colors.green : Colors.red;

      stationIcons[station.stationId] =
          await MarkerGenerator.createCustomMarkerBitmap(
            station.bikeCount,
            color,
            targetSize,
          );
    }

    _lastDataHash = currentHash;
    notifyListeners();
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  Future<void> determinePosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _currentLocation = LatLng(position.latitude, position.longitude);
      notifyListeners();
    } catch (e) {
      debugPrint("Location error: $e");
    }
  }

  void selectStation(Station station) {
    _selectedStation = station;
    notifyListeners();
  }

  void clearSelection() {
    _selectedStation = null;
    notifyListeners();
  }

  void findNearestStation(List<Station> stations) {
    if (stations.isEmpty || _currentLocation == null || _mapController == null)
      return;

    Station? nearest;
    double minDistance = double.infinity;

    for (var station in stations) {
      if (station.bikeCount > 0) {
        double dist = LocationUtils.calculateDistance(
          _currentLocation!,
          LatLng(station.latitude, station.longitude),
        );
        if (dist < minDistance) {
          minDistance = dist;
          nearest = station;
        }
      }
    }

    if (nearest != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(nearest.latitude, nearest.longitude),
          17,
        ),
      );
      selectStation(nearest);
    }
  }
}
