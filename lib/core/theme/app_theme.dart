import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';

/// Builds the app's [ThemeData] from the Eco-Clean Sanctuary tokens in [AppColors] /
/// [AppTextStyles], per Master Spec v9.0 (`docs/design/MASTER_SPEC_V9.md`).
///
/// Two hard rules baked in throughout: **Zero Shadows** (every elevation is 0; hairline
/// [AppColors.border] takes the place of drop shadows) and the **60-30-10** color ratio
/// ([AppColors.background]/[AppColors.surface] dominant, text/border structural, [AppColors.primary]
/// reserved for the one primary CTA or active tab).
abstract final class AppTheme {
  static ThemeData get light {
    final colorScheme = const ColorScheme.light().copyWith(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.textPrimary,
      error: AppColors.error,
      onError: AppColors.onPrimary,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      outline: AppColors.border,
      surfaceTint: Colors.transparent,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: TextTheme(
        headlineLarge: AppTextStyles.headlineLg,
        headlineMedium: AppTextStyles.headlineMd,
        titleLarge: AppTextStyles.titleLg,
        labelLarge: AppTextStyles.labelLg,
        labelMedium: AppTextStyles.labelMd,
        bodyLarge: AppTextStyles.bodyLg,
        bodyMedium: AppTextStyles.bodyMd,
        bodySmall: AppTextStyles.caption,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: AppTextStyles.titleLg,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          disabledBackgroundColor: AppColors.border,
          minimumSize: const Size.fromHeight(AppErgonomics.primaryCtaMinHeight),
          maximumSize: const Size(double.infinity, AppErgonomics.primaryCtaMaxHeight),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.control),
          ),
          textStyle: AppTextStyles.labelLg,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          minimumSize: const Size.fromHeight(AppErgonomics.primaryCtaMinHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.control),
          ),
          textStyle: AppTextStyles.labelLg,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        labelStyle: AppTextStyles.labelMd,
        hintStyle: AppTextStyles.caption,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.control),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.control),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.control),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.control),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.border, thickness: 1, space: 1),
    );
  }
}
