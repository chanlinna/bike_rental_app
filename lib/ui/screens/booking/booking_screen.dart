import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../ui/states/booking_state.dart';
import 'view_model/booking_view_model.dart';
import 'widgets/booking_content.dart';

class BookingScreen extends StatelessWidget {
  final String bikeId;

  const BookingScreen({super.key, required this.bikeId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookingViewModel(context.read<BookingState>()),
      child: Scaffold(body: BookingContent(bikeId: bikeId)),
    );
  }
}
