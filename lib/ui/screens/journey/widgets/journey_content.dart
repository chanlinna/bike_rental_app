import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/journey_view_model.dart';

import 'journey_empty_view.dart';
import 'journey_active_view.dart';
import 'journey_result_view.dart';

class JourneyContent extends StatelessWidget {
  final VoidCallback? onGoToMap;

  const JourneyContent({super.key, this.onGoToMap});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<JourneyViewModel>();

    if (!vm.hasActiveJourney && !vm.isFinished) {
      return JourneyEmptyView(onGoToMap: onGoToMap,);
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
