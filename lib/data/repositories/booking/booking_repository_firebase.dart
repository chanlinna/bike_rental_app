import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bike_rental_app/config/firebase_config.dart';
import 'package:bike_rental_app/data/dtos/booking_dto.dart';
import 'package:bike_rental_app/data/repositories/booking/booking_repository.dart';
import 'package:bike_rental_app/models/booking/booking.dart';

class BookingRepositoryFirebase implements BookingRepository {
  @override
  Future<Booking> createBooking({required String bikeId}) async {
    final url = FirebaseConfig.baseUri.replace(path: '/bookings.json');

    final now = DateTime.now();

    final booking = Booking(
      bookingId: '',
      bikeId: bikeId,
      reservedAt: now,
      bookingStatus: BookingStatus.reserved,
    );

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(BookingDto.toJson(booking)),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to create booking: ${response.body}');
    }

    final id = json.decode(response.body)['name'];

    return Booking(
      bookingId: id,
      bikeId: bikeId,
      reservedAt: now,
      bookingStatus: BookingStatus.reserved,
    );
  }

  @override
  Future<void> updateBooking(Booking booking) async {
    final url = FirebaseConfig.baseUri.replace(
      path: '/bookings/${booking.bookingId}.json',
    );

    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(BookingDto.toJson(booking)),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update booking: ${response.body}');
    }
  }

  @override
  Future<void> cancelBooking(String bookingId) async {
    final url = FirebaseConfig.baseUri.replace(
      path: '/bookings/$bookingId.json',
    );

    final response = await http.delete(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to cancel booking: ${response.body}');
    }
  }

  @override
  Future<void> markBikeAsBooked(String bikeId) async {
    final url = FirebaseConfig.baseUri.replace(path: '/bikes/$bikeId.json');

    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'status': 'book'}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to mark bike as booked: ${response.body}');
    }
  }

  @override
  Future<void> markBikeAsAvailable(String bikeId) async {
    final url = FirebaseConfig.baseUri.replace(path: '/bikes/$bikeId.json');

    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'status': 'available'}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to mark bike as available: ${response.body}');
    }
  }
}
