import 'package:flutter/material.dart';
import '../theme/theme.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.type = AppButtonType.primary,
    this.isFullWidth = true,
  });

  final String label;
  final VoidCallback? onTap;
  final AppButtonType type;
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    final isDisabled = onTap == null;

    Color background;
    Color textColor;

    switch (type) {
      case AppButtonType.primary:
        background = isDisabled ? AppColors.disabled : AppColors.primary;
        textColor = isDisabled ? AppColors.disabledText : AppColors.onPrimary;
        break;

      case AppButtonType.danger:
        background = isDisabled ? AppColors.disabled : AppColors.error;
        textColor = AppColors.onPrimary;
        break;

      case AppButtonType.secondary:
        background = AppColors.surfaceVariant;
        textColor = AppColors.primary;
        break;
    }

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: 48,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: AppRadii.medium),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

enum AppButtonType { primary, secondary, danger }
