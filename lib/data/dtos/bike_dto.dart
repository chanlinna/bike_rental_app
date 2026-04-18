import '../../models/bike/bike.dart'; 

class BikeDto {
  static Bike fromJson(String id, Map<String, dynamic> json) {
    return Bike(
      bikeId: id,
      stationId: json['stationId'] ?? '',
      bikeStatus: (json['status'] == 'book') ? BikeStatus.book : BikeStatus.available,
    );
  }
}