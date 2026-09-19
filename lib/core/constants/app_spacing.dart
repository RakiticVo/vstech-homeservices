/// Eco-Clean Sanctuary spacing grid and layout minimums.
/// Source of truth: `docs/design/MASTER_SPEC_V9.md`.
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  /// Alias for the standard screen edge gutter / page margin.
  static const double gutter = md;

  /// Minimum bottom padding a scrollable page body needs when a floating bottom nav dock is
  /// present, so the last card/button is never obscured when scrolled to the end (Master Spec
  /// v9.0 Part 3.3, `pb-28` to `pb-32`).
  static const double dockClearanceMin = 112;
  static const double dockClearanceMax = 128;
}

/// Border radius hierarchy — Master Spec v9.0 Part 3.4. Do not reach for `full`/`card` on small
/// elements or `chip` on large cards; each tier is reserved for its own component class.
abstract final class AppRadius {
  /// Small chips, status badges, tags.
  static const double chip = 8;

  /// Inputs, selection chips, the primary CTA button.
  static const double control = 12;

  /// Content cards and sheets.
  static const double card = 16;

  /// Reserved exclusively for the floating bottom nav dock and special round buttons.
  static const double full = 9999;
}

/// Ergonomics constants from the product design brief — do not shrink below these.
abstract final class AppErgonomics {
  static const double minTouchTarget = 44;
  static const double preferredTouchTarget = 48;
  static const double primaryCtaMinHeight = 48;
  static const double primaryCtaMaxHeight = 52;
}
