enum BookingStatus { reserved, active, completed, cancelled }

class Booking {
  final String bookingId;
  final String bikeId;

  final DateTime reservedAt;
  final DateTime? startTime;
  final DateTime? endTime;

  final BookingStatus bookingStatus;

  Booking({
    required this.bookingId,
    required this.reservedAt,
    this.startTime,
    this.endTime,
    required this.bookingStatus,
    required this.bikeId,
  });
}
