enum BookingStatus { reserved, active, completed, cancelled }

class Booking {
  final String bookingId;
  final DateTime reservedAt;
  final DateTime startTime;
  final DateTime expireTime;
  final BookingStatus bookingStatus;
  final String bikeId;

  Booking({
    required this.bookingId,
    required this.reservedAt,
    required this.startTime,
    required this.expireTime,
    required this.bookingStatus,
    required this.bikeId,
  });
}
