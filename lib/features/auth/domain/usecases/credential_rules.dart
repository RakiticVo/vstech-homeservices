/// Client-side mirrors of the backend's account rules (docs/reference/api/01-auth-profiles.md), so
/// users get instant feedback instead of a round-trip error.
abstract final class CredentialRules {
  static final RegExp _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  /// Same regex the backend enforces (`HS-400-0022`): 8+ chars with lower, upper case and a digit.
  static final RegExp _strongPassword = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$');

  /// Vietnamese mobile numbers: 0 or +84 followed by a 3/5/7/8/9 prefix and 8 digits.
  static final RegExp _vietnamesePhone = RegExp(r'^(0|\+84)[35789]\d{8}$');

  static const int fullNameMinLength = 2;
  static const int fullNameMaxLength = 100;

  static bool isValidEmail(String value) => _email.hasMatch(value.trim());

  /// Accepts the formatting users type ("0901 234 567", "0901.234.567").
  static bool isValidVietnamesePhone(String value) =>
      _vietnamesePhone.hasMatch(value.replaceAll(RegExp(r'[\s.\-()]'), ''));

  static bool isValidFullName(String value) {
    final length = value.trim().length;
    return length >= fullNameMinLength && length <= fullNameMaxLength;
  }

  static bool isStrongPassword(String value) => _strongPassword.hasMatch(value);
}
