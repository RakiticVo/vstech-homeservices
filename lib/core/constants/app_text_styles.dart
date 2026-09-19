import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';

/// Eco-Clean Sanctuary typography. Two font families only — Plus Jakarta Sans for headings/buttons,
/// Inter for body/numeric text. Sizes respect Master Spec v9.0's U50-ergonomics minimums (Part
/// 3.5): field labels >= 14px, input/body text >= 16px, card titles >= 18px, button text 16-17px.
abstract final class AppTextStyles {
  static TextStyle _jakarta({
    required double fontSize,
    required FontWeight fontWeight,
    required double height,
    Color? color,
  }) =>
      GoogleFonts.plusJakartaSans(
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height / fontSize,
        color: color,
      );

  static TextStyle _inter({
    required double fontSize,
    required FontWeight fontWeight,
    required double height,
    Color? color,
  }) =>
      GoogleFonts.inter(
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height / fontSize,
        color: color,
      );

  /// 700 / 28px / 36px line-height — page titles, hero headings.
  static TextStyle get headlineLg =>
      _jakarta(fontSize: 28, fontWeight: FontWeight.w700, height: 36, color: AppColors.textPrimary);

  /// 700 / 22px / 28px line-height — section headings.
  static TextStyle get headlineMd =>
      _jakarta(fontSize: 22, fontWeight: FontWeight.w700, height: 28, color: AppColors.textPrimary);

  /// 600 / 18px / 24px line-height — card titles (spec minimum for card titles is 18px).
  static TextStyle get titleLg =>
      _jakarta(fontSize: 18, fontWeight: FontWeight.w600, height: 24, color: AppColors.textPrimary);

  /// 600 / 16px / 22px line-height — button labels (spec: 16-17px, bold/semibold). Color is
  /// deliberately unset so it inherits the button's `foregroundColor` (white on a primary CTA,
  /// primary teal on an outlined secondary button) instead of fighting it.
  static TextStyle get labelLg => _jakarta(fontSize: 16, fontWeight: FontWeight.w600, height: 22);

  /// 500 / 14px / 20px line-height — field labels (spec minimum for labels is 14-15px).
  static TextStyle get labelMd =>
      _jakarta(fontSize: 14, fontWeight: FontWeight.w500, height: 20, color: AppColors.textPrimary);

  /// 400 / 16px / 24px line-height — primary body copy and form input text (spec minimum 16px,
  /// also prevents iOS auto-zoom on focus).
  static TextStyle get bodyLg =>
      _inter(fontSize: 16, fontWeight: FontWeight.w400, height: 24, color: AppColors.textPrimary);

  /// 400 / 14px / 20px line-height — secondary/supporting copy.
  static TextStyle get bodyMd =>
      _inter(fontSize: 14, fontWeight: FontWeight.w400, height: 20, color: AppColors.textSecondary);

  /// 500 / 14px / 20px line-height — placeholders, timestamps, fine-print notes.
  static TextStyle get caption => _inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 20,
        color: AppColors.textMuted,
      );

  /// 600 / 16px / 24px line-height — money amounts, quantities (spec: text_primary, bold).
  static TextStyle get numericLg =>
      _inter(fontSize: 16, fontWeight: FontWeight.w600, height: 24, color: AppColors.textPrimary);
}
