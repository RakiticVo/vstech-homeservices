/// Route name/path constants (kebab-case paths per CLAUDE.md naming conventions).
/// Feature modules add their own route constants here as they're scaffolded.
abstract final class AppRoutes {
  static const String splash = '/';

  // --- auth ---
  static const String login = '/auth/login';
  static const String register = '/auth/register';

  // Remaining routes (home, booking, tracking, checkout, messaging, worker/*, wallet) are added
  // here as their feature module is scaffolded — see the flutter-feature-scaffold skill.
}
