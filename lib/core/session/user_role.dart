/// Which side of the app a signed-in user belongs to. Only customers and workers use this app;
/// every other backend role (`SUPPLIER`, `ADMIN`) is [unsupported] and cannot sign in here.
enum UserRole {
  customer,
  worker,
  unsupported;

  /// Maps the backend `UserRole` enum (`docs/reference/api/11-appendices.md`).
  static UserRole fromApi(String? value) => switch (value) {
    'CUSTOMER' || 'B2B_CUSTOMER' => UserRole.customer,
    'WORKER' => UserRole.worker,
    _ => UserRole.unsupported,
  };

  /// Value sent to `POST /auth/register`.
  String get apiValue => switch (this) {
    UserRole.customer => 'CUSTOMER',
    UserRole.worker => 'WORKER',
    UserRole.unsupported => throw UnsupportedError('No API value for $this'),
  };
}
