import 'package:flutter/material.dart';
import '../../data/repositories/station_repository.dart';
import '../../data/repositories/bike_repository.dart';
import '../../models/station/station.dart';
import '../../models/bike/bike.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart'; 
import '../../utils/location_utils.dart'; 

class MapState extends ChangeNotifier {
  final StationRepository _repository;
  final BikeRepository _bikeRepository;
  
  List<Station> _allStations = [];
  List<Bike> _stationBikes = [];
  String _searchQuery = "";
  bool _isLoading = false;
  bool _isBikesLoading = false;

  MapState(this._repository, this._bikeRepository);

  List<Station> get stations => _allStations;
  List<Bike> get stationBikes => _stationBikes;
  bool get isLoading => _isLoading;
  bool get isBikesLoading => _isBikesLoading;

  Station? _selectedStation; 
  Station? get selectedStation => _selectedStation;

  GoogleMapController? _mapController;
  LatLng? _currentLocation;

  LatLng? get currentLocation => _currentLocation;

  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return Future.error('Location services are disabled.');

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied)
        return Future.error('Denied');
    }

    try {

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 5),
      );

      updateLocation(LatLng(position.latitude, position.longitude));
    } catch (e) {
      debugPrint("Location error: $e");
    }
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }

  void updateLocation(LatLng location) {
    _currentLocation = location;
    notifyListeners();
  }

  void findNearestStation() {
    // Safety checks
    if (_allStations.isEmpty ||
        _mapController == null ||
        _currentLocation == null) {
      return;
    }

    Station? nearest;
    double minDistance = double.infinity;

    for (var station in _allStations) {
      double dist = LocationUtils.calculateDistance(
        _currentLocation!,
        LatLng(station.latitude, station.longitude),
      );

      if (dist < minDistance) {
        minDistance = dist;
        nearest = station;
      }
    }

    if (nearest != null) {
      // Move the camera
      _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(nearest.latitude, nearest.longitude),
          17,
        ),
      );
      // Automatically select it to show the bike list
      selectStation(nearest);
    }
  }

  List<Station> get filteredStations {
    if (_searchQuery.isEmpty) return _allStations;
    return _allStations.where((s) => 
      s.stationName.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  void updateSearch(String query) {
    _searchQuery = query;
    notifyListeners(); 
  }

  Future<void> fetchStations() async {
    _isLoading = true;
    notifyListeners();
    try {
      _allStations = await _repository.getAllStations();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchBikesForStation(String stationId) async {
    _isBikesLoading = true;
    _stationBikes = [];
    notifyListeners();

    try {
      _stationBikes = await _bikeRepository.getBikesByStation(stationId);

      if (_selectedStation != null &&
          _selectedStation!.stationId == stationId) {
        _selectedStation = _selectedStation!.copyWith(
          bikeCount: _stationBikes.length, 
        );
      }
    } finally {
      _isBikesLoading = false;
      notifyListeners(); 
    }
  }

  void selectStation(Station station) {
    _selectedStation = station;

    notifyListeners();
    fetchBikesForStation(station.stationId);
  }

  void clearSelectedStation() {
    _selectedStation = null;
    _stationBikes = [];
    notifyListeners();
  }
}