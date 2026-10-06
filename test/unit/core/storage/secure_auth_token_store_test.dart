import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/storage/secure_auth_token_store.dart';

import '../../../helpers/mocks.dart';

void main() {
  late MockFlutterSecureStorage storage;
  late SecureAuthTokenStore store;

  setUp(() {
    storage = MockFlutterSecureStorage();
    store = SecureAuthTokenStore(storage);
    when(
      () => storage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((_) async {});
    when(() => storage.delete(key: any(named: 'key'))).thenAnswer((_) async {});
  });

  test('reads tokens from secure storage', () async {
    when(() => storage.read(key: SecureAuthTokenStore.accessTokenKey)).thenAnswer((_) async => 'a');
    when(() => storage.read(key: SecureAuthTokenStore.refreshTokenKey)).thenAnswer((_) async => 'r');

    expect(await store.readAccessToken(), 'a');
    expect(await store.readRefreshToken(), 'r');
  });

  test('saves both tokens', () async {
    await store.saveTokens(accessToken: 'a', refreshToken: 'r');

    verify(() => storage.write(key: SecureAuthTokenStore.accessTokenKey, value: 'a')).called(1);
    verify(() => storage.write(key: SecureAuthTokenStore.refreshTokenKey, value: 'r')).called(1);
  });

  test('clear deletes both tokens', () async {
    await store.clear();

    verify(() => storage.delete(key: SecureAuthTokenStore.accessTokenKey)).called(1);
    verify(() => storage.delete(key: SecureAuthTokenStore.refreshTokenKey)).called(1);
  });
}
