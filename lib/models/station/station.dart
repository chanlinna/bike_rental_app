class Station {
  final String stationId;
  final String stationName;
  final double latitude;
  final double longitude;
  final int bikeCount;

  Station({
    required this.stationId,
    required this.stationName,
    required this.latitude,
    required this.longitude,
    required this.bikeCount,
  });

  Station copyWith({int? bikeCount}) {
    return Station(
      stationId: stationId,
      stationName: stationName,
      latitude: latitude,
      longitude: longitude,
      bikeCount: bikeCount ?? this.bikeCount,
    );
  }
}

