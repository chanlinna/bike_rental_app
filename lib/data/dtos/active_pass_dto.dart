import 'package:bike_rental_app/models/pass/active_pass.dart';

class ActivePassDto {
  static ActivePass fromJson(Map<String, dynamic> json) {
    return ActivePass(
      passId: json['passId'] ?? '',
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }

  static Map<String, dynamic> toJson(ActivePass activePass) {
    return {
      'passId': activePass.passId,
      'startDate': activePass.startDate.toIso8601String(),
      'endDate': activePass.endDate.toIso8601String(),
    };
  }
}
