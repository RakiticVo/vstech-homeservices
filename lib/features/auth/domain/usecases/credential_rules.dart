/// Client-side mirrors of the backend's account rules (docs/reference/api/01-auth-profiles.md), so
/// users get instant feedback instead of a round-trip error.
abstract final class CredentialRules {
  static final RegExp _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  /// Same regex the backend enforces (`HS-400-0022`): 8+ chars with lower, upper case and a digit.
  static final RegExp _strongPassword = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$');

  static bool isValidEmail(String value) => _email.hasMatch(value.trim());


  static bool isStrongPassword(String value) => _strongPassword.hasMatch(value);
}
