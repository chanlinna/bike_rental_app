import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../ui/states/booking_state.dart';
import 'view_model/journey_view_model.dart';
import 'widgets/journey_content.dart';

class JourneyScreen extends StatelessWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JourneyViewModel(context.read<BookingState>()),
      child: const Scaffold(body: JourneyContent()),
    );
  }
}
