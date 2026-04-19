import '../../models/booking/booking.dart';

class BookingDto {
  static Booking fromJson(String id, Map<String, dynamic> json) {
    return Booking(
      bookingId: id,
      bikeId: json['bikeId'] ?? '',
      reservedAt: DateTime.parse(json['reservedAt']),
      startTime: json['startTime'] != null
          ? DateTime.parse(json['startTime'])
          : null,
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
      bookingStatus: _parseStatus(json['status']),
    );
  }

  static Map<String, dynamic> toJson(Booking booking) {
    return {
      'bikeId': booking.bikeId,
      'reservedAt': booking.reservedAt.toIso8601String(),
      'startTime': booking.startTime?.toIso8601String(),
      'endTime': booking.endTime?.toIso8601String(),
      'status': booking.bookingStatus.name,
    };
  }

  static BookingStatus _parseStatus(String? status) {
    switch (status) {
      case 'active':
        return BookingStatus.active;
      case 'completed':
        return BookingStatus.completed;
      case 'cancelled':
        return BookingStatus.cancelled;
      case 'reserved':
      default:
        return BookingStatus.reserved;
    }
  }
}
