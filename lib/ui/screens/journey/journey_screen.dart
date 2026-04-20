import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../ui/states/booking_state.dart';
import 'view_model/journey_view_model.dart';
import 'widgets/journey_content.dart';

class JourneyScreen extends StatelessWidget {
  final VoidCallback? onGoToMap;

  const JourneyScreen({super.key, this.onGoToMap});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JourneyViewModel(context.read<BookingState>()),
      child: Scaffold(body: JourneyContent(onGoToMap: onGoToMap,)),
    );
  }
}
