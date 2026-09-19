import 'package:flutter/material.dart';

/// Eco-Clean Sanctuary 1 color tokens — locked per Master Spec v9.0
/// (`docs/design/MASTER_SPEC_V9.md`, Part 1). This supersedes the earlier Material-3 token
/// export in `docs/design/DESIGN.md`'s front-matter, which is now reference-only.
///
/// This is the ONLY place raw color hex values may appear in this codebase — every widget must
/// reference these constants instead of hardcoding a `Color(0x...)`.
///
/// Hard rule from the spec: absolutely no pure black (`#000000`) anywhere in the UI — dark text
/// always uses [textPrimary], never black.
abstract final class AppColors {
  /// The single dominant accent (10% of the 60-30-10 ratio). Reserved for exactly one primary
  /// CTA per screen, or the active tab — never scattered across icons, badges, or borders.
  static const Color primary = Color(0xFF0D9488);

  /// Pressed/active state of [primary].
  static const Color primaryPressed = Color(0xFF0F766E);

  static const Color onPrimary = Color(0xFFFFFFFF);

  /// Light mint tint — badges, subtle highlights. Not a strong action color.
  static const Color secondary = Color(0xFFCCFBF1);

  /// Selected chip/card background, always paired with a [primary] border.
  static const Color secondarySurface = Color(0xFFF0FDFA);

  /// App-wide background — warm ivory, not stark white (60% of the color ratio, with [surface]).
  static const Color background = Color(0xFFFAF9F6);

  /// Card/sheet surface — pure white, sits on top of [background].
  static const Color surface = Color(0xFFFFFFFF);

  /// Headlines, field labels, prices, phone numbers. WCAG AAA on [background]/[surface].
  /// Never used as a large fill background (30% of the ratio, with [border]).
  static const Color textPrimary = Color(0xFF0F172A);

  /// Service descriptions, secondary addresses, supporting copy.
  static const Color textSecondary = Color(0xFF475569);

  /// Placeholders, timestamps, fine-print security notes.
  static const Color textMuted = Color(0xFF94A3B8);

  /// Hairline 1px border — replaces box-shadow everywhere (Zero Shadows rule).
  static const Color border = Color(0xFFE2E8F0);

  static const Color success = Color(0xFF10B981);
  static const Color successDark = Color(0xFF059669);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color errorAlt = Color(0xFFF43F5E);
}
