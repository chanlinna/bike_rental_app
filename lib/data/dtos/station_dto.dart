import '../../models/station/station.dart'; 

class StationDTO {
  static Station fromJson(String id, Map<String, dynamic> json) {
    return Station(
      stationId: id,
      stationName: json['stationName'] ?? '',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      bikeCount: json['bikeCount'] ?? 0,
    );
  }
}