import 'package:bike_rental_app/models/booking/booking.dart';

abstract class BookingRepository {
  Future<Booking> createBooking({required String bikeId});

  Future<void> updateBooking(Booking booking);

  Future<void> cancelBooking(String bookingId);

  Future<void> markBikeAsBooked(String bikeId);

  Future<void> markBikeAsAvailable(String bikeId);
}
