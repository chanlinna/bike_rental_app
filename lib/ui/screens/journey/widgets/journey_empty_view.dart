import 'package:bike_rental_app/ui/theme/theme.dart';
import 'package:bike_rental_app/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';

class JourneyEmptyView extends StatelessWidget {
  final VoidCallback? onGoToMap;

  const JourneyEmptyView({super.key, this.onGoToMap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Journey',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w800,
            height: 1.1,
          ).copyWith(color: AppColors.secondary),
        ),
        backgroundColor: AppColors.background,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('../../../../../../assets/images/empty_journey.jpg', height: 200),
              Text("No active journey", style: Theme.of(context).textTheme.titleLarge,),
              Text("Go to map to start your journey", style: Theme.of(context).textTheme.bodyLarge,),
              const SizedBox(height: 50),
              AppButton(label: "Go To Map", onTap: onGoToMap)
            ],
          ),
        ),
      ),
    );
  }
}