import 'package:flutter/material.dart';

class JourneyEmptyView extends StatelessWidget {
  const JourneyEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("No active journey"),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.popUntil(context, (r) => r.isFirst);
            },
            child: const Text("Go to Map"),
          ),
        ],
      ),
    );
  }
}
