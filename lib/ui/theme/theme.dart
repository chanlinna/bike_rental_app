import 'package:flutter/material.dart';

// Colors

class AppColors {
  static const Color primary = Color(0xFF376F3B);
  static const Color secondary = Color(0xFF294E2C);
  static const Color surface = Color(0xFFF1F2F4);
  static const Color error = Color(0xFFBA1A1A);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF141B2D);
  static const Color onSurfaceVariant = Color(0xFF7D8190);
  static const Color outline = Color(0xFF4B4B4B);
  static const Color outlineVariant = Color(0xFFD5D7DC);
  static const Color background = Color(0xFFF1F2F4);
  static const Color surfaceVariant = Color(0xFFEDEFF2);
  static const Color disabled = Color(0xFFB8C0C6);
  static const Color disabledText = Color(0xFF8F9AA4);
}

// Text Styles

class AppTextStyles {
  // 8pt grid spacing constants
  static const double spaceXS = 8.0;
  static const double spaceS = 16.0;
  static const double spaceM = 24.0;
  static const double spaceL = 32.0;
  static const double spaceXL = 40.0;
  static const double spaceXXL = 48.0;

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    height: 32 / 24, // 32px line height
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    height: 28 / 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );
}

// Theme

ThemeData appTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Eesti',

  // Color scheme
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    secondary: AppColors.secondary,
    onSecondary: AppColors.onPrimary,
    error: AppColors.error,
    onError: AppColors.onPrimary,
    surface: AppColors.surface,
    onSurface: AppColors.onSurface,
    surfaceContainerHighest: AppColors.surfaceVariant,
    onSurfaceVariant: AppColors.onSurfaceVariant,
    outline: AppColors.outline,
    outlineVariant: AppColors.outlineVariant,
  ),

  scaffoldBackgroundColor: AppColors.background,

  // Typography
  textTheme: const TextTheme(
    headlineSmall: AppTextStyles.headlineSmall,
    titleLarge: AppTextStyles.titleLarge,
    titleMedium: AppTextStyles.titleMedium,
    bodyLarge: AppTextStyles.bodyLarge,
    bodyMedium: AppTextStyles.bodyMedium,
    labelLarge: AppTextStyles.labelLarge,
  ),

  // Elevated / Filled button — Primary
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return AppColors.disabled;
        return AppColors.primary;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled))
          return AppColors.disabledText;
        return AppColors.onPrimary;
      }),
      textStyle: WidgetStatePropertyAll(AppTextStyles.labelLarge),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          horizontal: AppTextStyles.spaceM,
          vertical: AppTextStyles.spaceS,
        ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      elevation: const WidgetStatePropertyAll(0),
    ),
  ),

  // Outlined button — Alternative
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return AppColors.disabled;
        return AppColors.primary;
      }),
      side: WidgetStateProperty.resolveWith((states) {
        final color = states.contains(WidgetState.disabled)
            ? AppColors.disabled
            : AppColors.primary;
        return BorderSide(color: color, width: 1.5);
      }),
      textStyle: WidgetStatePropertyAll(AppTextStyles.labelLarge),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          horizontal: AppTextStyles.spaceM,
          vertical: AppTextStyles.spaceS,
        ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return AppColors.primary.withOpacity(0.06);
        }
        if (states.contains(WidgetState.pressed)) {
          return AppColors.primary.withOpacity(0.12);
        }
        return null;
      }),
    ),
  ),

  // Bottom Navigation Bar
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.background,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.secondary,
    selectedLabelStyle: AppTextStyles.labelLarge.copyWith(fontSize: 12),
    unselectedLabelStyle: AppTextStyles.bodyMedium.copyWith(fontSize: 12),
    showSelectedLabels: true,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),
);
