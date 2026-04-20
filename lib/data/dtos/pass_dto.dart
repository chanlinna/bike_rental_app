import 'package:bike_rental_app/models/pass/pass.dart';

class PassDto {
  static Pass fromJson(String id, Map<String, dynamic> json) {
    return Pass(
      passId: id,
      passType: _parsePassType(json['passType']),
      price: (json['price'] as num?)?.toDouble() ?? 0,
    );
  }

  static Map<String, dynamic> toJson(Pass pass) {
    return {'passType': pass.passType.name, 'price': pass.price};
  }

  static PassType _parsePassType(String? value) {
    switch (value) {
      case 'daily':
        return PassType.daily;
      case 'weekly':
        return PassType.weekly;
      case 'monthly':
        return PassType.monthly;
      default:
        throw StateError('Unknown pass type: $value');
    }
  }
}
