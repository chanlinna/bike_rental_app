import 'package:bike_rental_app/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/journey_view_model.dart';

class JourneyActiveView extends StatelessWidget {
  const JourneyActiveView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<JourneyViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Current Journey")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(vm.formattedTime, style: const TextStyle(fontSize: 40)),

          const SizedBox(height: 20),

          AppButton(
            label: "End Trip",
            type: AppButtonType.danger,
            onTap: vm.endJourney,
          ),
        ],
      ),
    );
  }
}
