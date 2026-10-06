import 'package:flutter_test/flutter_test.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/failure_message.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations_en.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations_vi.dart';

void main() {
  final vi = AppLocalizationsVi();
  final en = AppLocalizationsEn();

  Failure server(String code) => Failure(kind: NetworkErrorKind.server, errorCode: code, statusCode: 400);

  test('maps known HS codes to localized messages', () {
    expect(vi.failureMessage(server('HS-401-0002')), vi.apiErrorInvalidCredentials);
    expect(en.failureMessage(server('HS-400-0020')), en.apiErrorInsufficientBalance);
    expect(vi.failureMessage(server('HS-404-0010')), vi.apiErrorBookingNotFound);
  });

  test('HS-409-0002 depends on context', () {
    expect(vi.failureMessage(server('HS-409-0002'), context: FailureContext.auth), vi.apiErrorAccountExists);
    expect(vi.failureMessage(server('HS-409-0002'), context: FailureContext.wallet), vi.apiErrorTransactionInProgress);
  });

  test('falls back on the error kind when there is no known code', () {
    expect(vi.failureMessage(const Failure(kind: NetworkErrorKind.timeout)), vi.apiErrorTimeout);
    expect(vi.failureMessage(const Failure(kind: NetworkErrorKind.noConnection)), vi.apiErrorNoConnection);
    expect(vi.failureMessage(server('HS-999-9999')), vi.apiErrorUnknown);
    expect(vi.failureMessage(const Failure(kind: NetworkErrorKind.server, statusCode: 401)), vi.apiErrorSessionExpired);
  });

  test('never exposes the raw error code', () {
    for (final code in ['HS-400-0001', 'HS-500-0001', 'HS-503-0001']) {
      expect(vi.failureMessage(server(code)), isNot(contains('HS-')));
    }
  });
}
