import 'package:flutter/material.dart';
import '../../../../data/repositories/bike_repository.dart';
import '../../../../models/bike/bike.dart';

class BikeViewModel extends ChangeNotifier {
  final BikeRepository _bikeRepository;

  List<Bike> _bikes = [];
  bool _isLoading = false;

  BikeViewModel(this._bikeRepository);

  List<Bike> get bikes => _bikes;
  bool get isLoading => _isLoading;

  Future<void> fetchBikesForStation(String stationId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _bikes = await _bikeRepository.getBikesByStation(stationId);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
