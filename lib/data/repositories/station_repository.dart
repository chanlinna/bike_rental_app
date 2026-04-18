import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dtos/station_dto.dart';
import '../../models/station/station.dart'; 
import '../../config/firebase_config.dart'; 

class StationRepository {
  Future<List<Station>> getAllStations() async {
    final url = FirebaseConfig.baseUri.replace(path: '/stations.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic>? data = json.decode(response.body);
      if (data == null) return [];

      // Explicitly typing the map result to List<Station>
      return data.entries.map<Station>((entry) {
        return StationDTO.fromJson(entry.key, entry.value);
      }).toList();
    } else {
      throw Exception('Failed to load stations');
    }
  }
}