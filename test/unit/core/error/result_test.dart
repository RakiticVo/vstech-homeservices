import 'package:flutter_test/flutter_test.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';

void main() {
  test('guard wraps values in Ok', () async {
    final result = await Result.guard(() async => 42);
    expect(result, isA<Ok<int>>().having((r) => r.value, 'value', 42));
  });

  test('guard converts NetworkException into Err with the same code', () async {
    final result = await Result.guard<int>(
      () async =>
          throw const NetworkException(kind: NetworkErrorKind.server, errorCode: 'HS-404-0010', statusCode: 404),
    );
    expect(
      result,
      isA<Err<int>>().having(
        (r) => r.failure,
        'failure',
        const Failure(kind: NetworkErrorKind.server, errorCode: 'HS-404-0010', statusCode: 404),
      ),
    );
  });

  test('guard converts unexpected errors into an unknown failure', () async {
    final result = await Result.guard<int>(() async => throw StateError('boom'));
    expect(result, isA<Err<int>>().having((r) => r.failure.kind, 'kind', NetworkErrorKind.unknown));
  });
}
