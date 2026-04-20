import 'package:bike_rental_app/ui/theme/theme.dart';
import 'package:bike_rental_app/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/journey_view_model.dart';

class JourneyResultView extends StatelessWidget {
  const JourneyResultView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<JourneyViewModel>();
    final theme = Theme.of(context);

    Widget buildRow(
      String label,
      String value, {
      bool isTotal = false,
      Color? valueColor,
    }) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal
                ? theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  )
                : theme.textTheme.bodyMedium,
          ),
          Text(
            value,
            style: isTotal
                ? theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20, 
                    color: valueColor ?? AppColors.primary,
                  )
                : theme.textTheme.bodyMedium,
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trip Summary',
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
            Container(
              padding: AppSpacings.cardPadding,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.outlineVariant),
                borderRadius: AppRadii.small,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildRow("Duration", vm.formattedTime),
                  const SizedBox(height: AppSpacings.s),
                  buildRow("Base Price (first 2 min)", "\$0.00"),
                  const SizedBox(height: AppSpacings.s),
                  buildRow("Rate", "\$0.25 / 5 min"),
                  const Divider(),
                  buildRow(
                    "Total Charged",
                    "\$${vm.price.toStringAsFixed(2)}",
                    isTotal: true,
                    valueColor: AppColors.secondary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacings.l),
            AppButton(
              label: "Confirm Payment",
              onTap: () {
                context.read<JourneyViewModel>().clear();
                Navigator.popUntil(context, (r) => r.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }
}
