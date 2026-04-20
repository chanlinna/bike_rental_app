import 'package:bike_rental_app/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/journey_view_model.dart';

class JourneyResultView extends StatelessWidget {
  const JourneyResultView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<JourneyViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Trip Summary")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Duration: ${vm.formattedTime}"),
          const SizedBox(height: 10),

          Text("Price: \$${vm.price.toStringAsFixed(2)}"),

          const SizedBox(height: 20),

          AppButton(
            label: "Back to Map",
            onTap: () {
              context.read<JourneyViewModel>().clear();
              Navigator.popUntil(context, (r) => r.isFirst);
            },
          ),
        ],
      ),
    );
  }
}
