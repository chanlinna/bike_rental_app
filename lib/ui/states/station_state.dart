import 'package:flutter/material.dart';
import '../../data/repositories/station_repository.dart';
import '../../data/repositories/bike_repository.dart';
import '../../models/station/station.dart';
import '../../models/bike/bike.dart';

class StationState extends ChangeNotifier {
  final StationRepository _stationRepository;
  final BikeRepository _bikeRepository;

  List<Station> _allStations = [];
  bool _isLoading = false;

  StationState(this._stationRepository, this._bikeRepository);

  List<Station> get allStations => _allStations;
  bool get isLoading => _isLoading;

  Future<void> fetchStations() async {
    _isLoading = true;
    notifyListeners();
    try {
      _allStations = await _stationRepository.getAllStations();
      // Start background sync immediately to update pin colors
      await syncAllStationCounts();
    } catch (e) {
      debugPrint("Fetch error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> syncAllStationCounts() async {
    for (var i = 0; i < _allStations.length; i++) {
      final station = _allStations[i];
      try {
        final bikes = await _bikeRepository.getBikesByStation(
          station.stationId,
        );
        final availableCount = bikes
            .where((b) => b.bikeStatus == BikeStatus.available)
            .length;

        _allStations[i] = station.copyWith(bikeCount: availableCount);
        notifyListeners();
      } catch (e) {
        debugPrint("Sync error for ${station.stationId}: $e");
      }
    }
  }
}
