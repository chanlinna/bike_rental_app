import 'package:bike_rental_app/ui/theme/theme.dart';
import 'package:bike_rental_app/ui/widgets/app_button.dart';
import 'package:bike_rental_app/ui/widgets/bike_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/booking_view_model.dart';

class BookingView extends StatelessWidget {
  final String bikeId;

  const BookingView({super.key, required this.bikeId});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<BookingViewModel>();
    final theme = Theme.of(context);

    Widget buildPurchasePass() {
      return Container(
        padding: AppSpacings.cardPadding,
        decoration: BoxDecoration(
          color: AppColors.warning,
          borderRadius: AppRadii.small,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.local_offer,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: AppSpacings.s),
                Text(
                  'Purchase pass to save cost',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.warningText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacings.m),
            AppButton(
              label: "Purchase Pass",
              onTap: () {
                Navigator.pushNamed(context, '/subscriptions');
              },
              isFullWidth: false,
            ),
          ],
        ),
      );
    }

    Widget buildPricing() {
      return Container(
        padding: AppSpacings.cardPadding,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.outlineVariant),
          borderRadius: AppRadii.small,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.receipt, size: 20, color: Colors.black),
                const SizedBox(width: AppSpacings.m),
                Text(
                  "Ticket",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacings.s),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Base price (first 30 min)",
                  style: theme.textTheme.bodySmall,
                ),
                Text("\$1.40", style: theme.textTheme.bodySmall),
              ],
            ),

            const SizedBox(height: AppSpacings.s),

            Container(
              height: 1,
              decoration: BoxDecoration(
                color: AppColors.outlineVariant,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: AppSpacings.s),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Then", style: theme.textTheme.bodySmall),
                Text(
                  "\$1.50 / 30 min",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.warningText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking"),
        backgroundColor: AppColors.background,
      ),
      body: Padding(
        padding: AppSpacings.screenPadding,
        child: Column(
          children: [
            BikeTile(
              bikeId: bikeId,
              status: "Available",
              type: BikeTileType.info,
            ),


            const SizedBox(height: AppSpacings.l),

            buildPurchasePass(),

            const SizedBox(height: AppSpacings.l),

            buildPricing(),

            const Spacer(),

            AppButton(
              label: "Confirm Booking",
              onTap: vm.isLoading ? null : () => vm.confirmBooking(bikeId),
            ),
          ],
        ),
      ),
    );
  }
}
