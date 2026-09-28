import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';

/// App typography system locked to `GoogleFonts.sourceSans3` per user requirements.
/// Sizes respect Master Spec v9.0's U50-ergonomics minimums: field labels >= 14px,
/// input/body text >= 16px, card titles >= 18px, button text 16-17px.
abstract final class AppTextStyles {
  static TextStyle _font({
    required double fontSize,
    required FontWeight fontWeight,
    required double height,
    Color? color,
    double? letterSpacing,
  }) =>
      GoogleFonts.sourceSans3(
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height / fontSize,
        color: color,
        letterSpacing: letterSpacing,
      );

  /// 700 / 28px / 36px line-height — page titles, hero headings.
  static TextStyle get headlineLg =>
      _font(fontSize: 28, fontWeight: FontWeight.w700, height: 36, color: AppColors.textPrimary);

  /// 700 / 22px / 28px line-height — section headings.
  static TextStyle get headlineMd =>
      _font(fontSize: 22, fontWeight: FontWeight.w700, height: 28, color: AppColors.textPrimary);

  /// 600 / 18px / 24px line-height — card titles (spec minimum for card titles is 18px).
  static TextStyle get titleLg =>
      _font(fontSize: 18, fontWeight: FontWeight.w600, height: 24, color: AppColors.textPrimary);

  /// 600 / 16px / 22px line-height — button labels (spec: 16-17px, bold/semibold).
  static TextStyle get labelLg =>
      _font(fontSize: 16, fontWeight: FontWeight.w600, height: 22);

  /// 500 / 14px / 20px line-height — field labels (spec minimum for labels is 14-15px).
  static TextStyle get labelMd =>
      _font(fontSize: 14, fontWeight: FontWeight.w500, height: 20, color: AppColors.textPrimary);

  /// 400 / 16px / 24px line-height — primary body copy and form input text (prevents iOS auto-zoom).
  static TextStyle get bodyLg =>
      _font(fontSize: 16, fontWeight: FontWeight.w400, height: 24, color: AppColors.textPrimary);

  /// 400 / 14px / 20px line-height — secondary descriptions, helper text.
  static TextStyle get bodyMd =>
      _font(fontSize: 14, fontWeight: FontWeight.w400, height: 20, color: AppColors.textSecondary);

  /// 400 / 12px / 16px line-height — timestamps, metadata, captions.
  static TextStyle get caption =>
      _font(fontSize: 12, fontWeight: FontWeight.w400, height: 16, color: AppColors.textMuted);

  /// 700 / 18px / 24px line-height — price display (tabular numbers).
  static TextStyle get priceLg =>
      _font(fontSize: 18, fontWeight: FontWeight.w700, height: 24, color: AppColors.textPrimary);

  /// 700 / 22px / 28px line-height — hero price display on totals/invoices.
  static TextStyle get priceXl =>
      _font(fontSize: 22, fontWeight: FontWeight.w700, height: 28, color: AppColors.primary);

  // --- Aliases for standard typography conventions ---
  static TextStyle get headlineLarge => headlineLg;
  static TextStyle get headlineMedium => headlineMd;
  static TextStyle get headlineSmall => titleLg;
  static TextStyle get headlineSm => titleLg;
  static TextStyle get displayLarge => headlineLg;
  static TextStyle get displayMedium => headlineLg;
  static TextStyle get displaySmall => headlineLg;
  static TextStyle get displayMd => headlineLg;
  static TextStyle get displaySm => headlineLg;
  static TextStyle get labelLarge => labelLg;
  static TextStyle get labelMedium => labelMd;
  static TextStyle get labelSmall => caption;
  static TextStyle get bodyLarge => bodyLg;
  static TextStyle get bodyMedium => bodyMd;
  static TextStyle get bodySmall => caption;
  static TextStyle get bodySm => bodyMd;
  static TextStyle get buttonText => labelLg;
}
