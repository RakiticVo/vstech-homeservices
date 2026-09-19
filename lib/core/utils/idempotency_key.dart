import 'package:uuid/uuid.dart';

/// Generates client-side idempotency keys required on every state-changing POST
/// (bookings, payments, withdrawals, dispatch accept/decline — see
/// `docs/reference/api/00-foundation.md`). Sent as the `X-Idempotency-Key` header.
abstract final class IdempotencyKey {
  static const _uuid = Uuid();

  static String generate() => _uuid.v4();
}
