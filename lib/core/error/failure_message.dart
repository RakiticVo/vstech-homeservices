import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

/// Where a failure happened — needed because `HS-409-0002` means "account exists" during auth
/// but "transaction in progress" for wallet calls (`docs/reference/api/00-foundation.md`).
enum FailureContext { general, auth, wallet }

/// Maps a [Failure] to a localized, user-facing message. Raw `HS-XXX-XXXX` codes and dio errors
/// never reach the UI.
extension FailureMessageX on AppLocalizations {
  String failureMessage(Failure failure, {FailureContext context = FailureContext.general}) {
    final byCode = _messageForCode(failure.errorCode, context);
    if (byCode != null) return byCode;
    return switch (failure.kind) {
      NetworkErrorKind.timeout => apiErrorTimeout,
      NetworkErrorKind.noConnection => apiErrorNoConnection,
      _ when failure.isUnauthorized => apiErrorSessionExpired,
      _ => apiErrorUnknown,
    };
  }

  String? _messageForCode(String? code, FailureContext context) => switch (code) {
    'HS-400-0001' => apiErrorInvalidInput,
    'HS-400-0002' => apiErrorScheduleInvalid,
    'HS-400-0003' => apiErrorLocationInvalid,
    'HS-400-0010' => apiErrorInvalidTransition,
    'HS-400-0011' => apiErrorMissingIdempotency,
    'HS-400-0012' => apiErrorPriceLimit,
    'HS-400-0013' => apiErrorBookingCompleted,
    'HS-400-0014' => apiErrorDisputeInvalid,
    'HS-400-0015' => apiErrorDisputeResolveInvalid,
    'HS-400-0020' => apiErrorInsufficientBalance,
    'HS-400-0021' => apiErrorWithdrawalProcessed,
    'HS-400-0022' => apiErrorWeakPassword,
    'HS-400-0030' => apiErrorApplianceTypeInvalid,
    'HS-400-0031' => apiErrorNoFieldToUpdate,
    'HS-401-0001' => apiErrorSessionExpired,
    'HS-401-0002' => apiErrorInvalidCredentials,
    'HS-403-0001' => apiErrorForbidden,
    'HS-403-0004' => apiErrorChatForbidden,
    'HS-403-0005' => apiErrorCallLogForbidden,
    'HS-403-0006' || 'HS-403-0007' => apiErrorNotificationForbidden,
    'HS-404-0001' => apiErrorNotFound,
    'HS-404-0002' => apiErrorProfileNotFound,
    'HS-404-0003' => apiErrorCategoryNotFound,
    'HS-404-0010' => apiErrorBookingNotFound,
    'HS-404-0011' => apiErrorDispatchNotFound,
    'HS-404-0020' => apiErrorWalletNotFound,
    'HS-404-0021' => apiErrorWithdrawalNotFound,
    'HS-404-0030' => apiErrorAssetNotFound,
    'HS-409-0001' => apiErrorProfileConflict,
    'HS-409-0002' => context == FailureContext.wallet ? apiErrorTransactionInProgress : apiErrorAccountExists,
    'HS-409-0003' => apiErrorAssetUnderWarranty,
    'HS-409-0005' => apiErrorChatClosed,
    'HS-429-0001' || 'HS-429-0002' => apiErrorTooManyRequests,
    'HS-503-0001' => apiErrorDispatchUnavailable,
    _ => null,
  };
}
