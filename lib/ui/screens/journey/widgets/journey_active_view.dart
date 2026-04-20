import 'package:bike_rental_app/ui/states/pass_state.dart';
import 'package:bike_rental_app/ui/theme/theme.dart';
import 'package:bike_rental_app/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/journey_view_model.dart';

class JourneyActiveView extends StatelessWidget {
  const JourneyActiveView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<JourneyViewModel>();
    final passState = context.watch<PassState>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Current Journey',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w800,
            height: 1.1,
          ).copyWith(color: AppColors.secondary),
        ),
        automaticallyImplyLeading: false,
        leading: null,
        backgroundColor: AppColors.background,
      ),
      body: Padding(
        padding: AppSpacings.screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Timer card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: AppRadii.medium,
                border: Border.all(color: AppColors.outlineVariant),
              ),
              child: Column(
                children: [
                  const Icon(Icons.timer, size: 100, color: AppColors.primary),
                  const SizedBox(height: 12),
                  Text(
                    vm.formattedTime,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (!passState.hasActivePass)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Current Cost",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "\$${vm.price.toStringAsFixed(2)}",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            AppButton(
              label: "End Trip",
              type: AppButtonType.danger,
              onTap: vm.endJourney,
            ),
          ],
        ),
      ),
    );
  }
}
