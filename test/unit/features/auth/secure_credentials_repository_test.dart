import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/session/user_role.dart';
import 'package:vstech_home_services/features/auth/data/repositories/secure_credentials_repository.dart';
import 'package:vstech_home_services/features/auth/domain/entities/remembered_credentials.dart';

import '../../../helpers/mocks.dart';

void main() {
  late MockFlutterSecureStorage storage;
  late SecureCredentialsRepository repository;

  setUp(() {
    storage = MockFlutterSecureStorage();
    repository = SecureCredentialsRepository(storage);
    when(
      () => storage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((_) async {});
    when(() => storage.delete(key: any(named: 'key'))).thenAnswer((_) async {});
  });

  test('save then read round-trips per role', () async {
    String? stored;
    when(
      () => storage.write(
        key: 'auth.remembered.worker',
        value: any(named: 'value'),
      ),
    ).thenAnswer((invocation) async {
      stored = invocation.namedArguments[#value] as String;
    });
    when(() => storage.read(key: 'auth.remembered.worker')).thenAnswer((_) async => stored);

    const credentials = RememberedCredentials(identifier: '0909 123 456', password: 'Secret123');
    await repository.save(UserRole.worker, credentials);

    expect(await repository.read(UserRole.worker), credentials);
  });

  test('read returns null when nothing is stored', () async {
    when(() => storage.read(key: any(named: 'key'))).thenAnswer((_) async => null);

    expect(await repository.read(UserRole.customer), isNull);
  });

  test('corrupt data is discarded', () async {
    when(() => storage.read(key: 'auth.remembered.customer')).thenAnswer((_) async => 'not-json');

    expect(await repository.read(UserRole.customer), isNull);
    verify(() => storage.delete(key: 'auth.remembered.customer')).called(1);
  });

  test('clear deletes only that role', () async {
    await repository.clear(UserRole.customer);

    verify(() => storage.delete(key: 'auth.remembered.customer')).called(1);
    verifyNever(() => storage.delete(key: 'auth.remembered.worker'));
  });
}
