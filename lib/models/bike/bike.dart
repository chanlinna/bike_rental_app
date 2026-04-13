enum BikeStatus { available, book }

class Bike {
  final String bikeId;
  final String stationId;
  final BikeStatus bikeStatus;

  Bike({
    required this.bikeId,
    required this.stationId,
    required this.bikeStatus,
  });
}
