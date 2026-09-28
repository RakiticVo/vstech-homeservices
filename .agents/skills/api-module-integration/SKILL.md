---
name: api-module-integration
description: Wire a Flutter feature to a backend API module using the reused contracts in docs/reference/api/. Use when implementing a remote datasource, DTOs, or repository for any feature that talks to the network (auth, bookings, wallet, chat, tracking, voip, etc.).
---

# API Module Integration

The backend is built and owned by a separate team; this repo only consumes the documented contracts.
Never invent an endpoint, field, or status code that isn't in `docs/reference/api/`.

## Steps

1. **Find the contract.** Match the feature to its file in `docs/reference/api/`
   (`01-auth-profiles`, `02-bookings`, `03-categories-dispatch`, `05-wallet-payments`,
   `06-withdrawals`, `07-chat`, `08-notifications`, `09-location-tracking`, `10-voip`). Read
   `00-foundation.md` first if you haven't already — it defines the envelope, auth, and pagination
   rules every module follows (with chat/notifications as the pagination exception).

2. **Define DTOs with freezed**, one pair per operation — never a shared class between a request and
   a response, even when fields look identical. Match the contract's field names and types exactly
   (no extra fields, no missing fields, no renaming to "nicer" Dart names without a `@JsonKey`).

3. **Implement the datasource** (`data/datasources/<name>_remote_datasource.dart`) using the shared
   `ApiClient` (dio) — never instantiate a raw `Dio()` or use `http` directly. Every call parses the
   response through `ApiResponse<T>` before returning domain data; treat `errorCode != null` as a
   failure regardless of HTTP status.

4. **Idempotency:** if the operation is a state-changing POST (booking creation, payment, withdrawal,
   dispatch accept/decline, etc.), attach `X-Idempotency-Key` via
   `core/utils/idempotency_key.dart::IdempotencyKey.generate()`. Check the specific module doc —
   not every POST needs it, but payments/bookings/withdrawals always do.

5. **Map errors**: translate `HS-XXX-XXXX` codes (catalog in `docs/reference/api/11-appendices.md`)
   to localized, user-facing messages in the repository layer — the BLoC/Cubit should only ever see a
   typed failure/state, never a raw error code or dio exception.

6. **Implement the repository** (`data/repositories/<name>_repository_impl.dart`) against the abstract
   `domain/repositories/<name>_repository.dart` interface, and register both in the `injectable`
   module so `get_it` resolves the interface to the implementation.

7. **Realtime endpoints** (chat, tracking, dispatch, voip signaling) use STOMP over WebSocket, not
   plain REST polling — see the per-module doc for topic names and event payloads. Scope the
   connection lifecycle to the owning BLoC (open on create, close on close).

8. If a needed backend capability genuinely isn't documented yet, stop and flag it to the user rather
   than guessing a shape — do not fabricate an endpoint or a field.
