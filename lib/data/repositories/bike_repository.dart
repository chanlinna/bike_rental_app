import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/bike/bike.dart';
import '../dtos/bike_dto.dart';
import '../../config/firebase_config.dart';

class BikeRepository {
  Future<List<Bike>> getBikesByStation(String stationId) async {
    try {
      final url = FirebaseConfig.baseUri.replace(
        path: '/bikes.json',
        queryParameters: {
          'orderBy': '"stationId"', 
          'equalTo': '"$stationId"',
        },
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic>? data = json.decode(response.body);
        if (data == null) return [];

        return data.entries
            .map<Bike>((e) => BikeDto.fromJson(e.key, e.value))
            .toList();
      }
      return [];
    } catch (e) {
      print("Error fetching bikes: $e"); 
      return [];
    }
  }
}
