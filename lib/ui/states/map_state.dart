import 'package:flutter/material.dart';
import '../../data/repositories/station_repository.dart';
import '../../data/repositories/bike_repository.dart';
import '../../models/station/station.dart';
import '../../models/bike/bike.dart';

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

  Station? _selectedStation; // To keep track of the chosen station
  Station? get selectedStation => _selectedStation;

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