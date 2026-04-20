import 'package:bike_rental_app/ui/screens/pass/view_model/pass_view_model.dart';
import 'package:bike_rental_app/ui/theme/theme.dart';
import 'package:bike_rental_app/ui/utils/pass_time.dart';
import 'package:bike_rental_app/ui/utils/remaining_time.dart';
import 'package:flutter/material.dart';

class ActivePassCardStatic extends StatelessWidget {
  const ActivePassCardStatic({
    required this.activePass,
    required this.activePlan,
    required this.onExpired,
  });

  final ActivePass activePass;
  final Pass? activePlan;
  final VoidCallback onExpired;

  @override
  Widget build(BuildContext context) {
    final String planName = activePlan?.displayName ?? 'Active Pass';

    return Material(
      color: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: AppColors.primary.withValues(alpha: 0.55),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppTextStyles.spaceS - 2,
          AppTextStyles.spaceS - 2,
          AppTextStyles.spaceS - 2,
          AppTextStyles.spaceXS,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    planName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.secondary,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTextStyles.spaceXS - 1,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.check_circle,
                        size: 13,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Active',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTextStyles.spaceS - 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.access_time,
                  size: 34,
                  color: AppColors.onSurface,
                ),
                const SizedBox(width: AppTextStyles.spaceXS),
                Center(
                  child: RemainingTime(
                    expiresAt: activePass.endDate,
                    onExpired: onExpired,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF9A5B00),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTextStyles.spaceXS),
            Center(
              child: Text(
                PassTime.formatExpiryLabel(activePass.endDate),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
