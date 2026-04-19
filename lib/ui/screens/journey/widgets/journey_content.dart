import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/journey_view_model.dart';

import 'journey_empty_view.dart';
import 'journey_active_view.dart';
import 'journey_result_view.dart';

class JourneyContent extends StatelessWidget {
  const JourneyContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<JourneyViewModel>();

    if (!vm.hasActiveJourney && !vm.isFinished) {
      return const JourneyEmptyView();
    }

    if (vm.hasActiveJourney) {
      return const JourneyActiveView();
    }

    if (vm.isFinished) {
      return const JourneyResultView();
    }

    return const SizedBox();
  }
}
