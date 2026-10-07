import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/session/user_role.dart';
import 'package:vstech_home_services/features/auth/domain/entities/app_user.dart';
import 'package:vstech_home_services/features/auth/domain/entities/profile_update.dart';
import 'package:vstech_home_services/features/auth/domain/entities/user_profile.dart';
import 'package:vstech_home_services/features/auth/domain/usecases/credential_rules.dart';
import 'package:vstech_home_services/features/auth/domain/usecases/login_use_case.dart';
import 'package:vstech_home_services/features/auth/domain/usecases/phone_normalizer.dart';
import 'package:vstech_home_services/features/auth/domain/usecases/register_use_case.dart';
import 'package:vstech_home_services/features/auth/domain/usecases/update_profile_use_case.dart';

import '../../../fixtures/auth/auth_fixtures.dart';
import '../../../helpers/mocks.dart';

void main() {
  late MockAuthRepository authRepository;
  late MockProfileRepository profileRepository;

  setUpAll(() => registerFallbackValue(const ProfileUpdate()));

  setUp(() {
    authRepository = MockAuthRepository();
    profileRepository = MockProfileRepository();
  });

  test('normalizePhone strips spaces, dots and dashes', () {
    expect(normalizePhone(' 0901 234.567-8 '), '09012345678');
  });

  group('LoginUseCase', () {
    setUp(() {
      when(
        () => authRepository.login(
          identifier: any(named: 'identifier'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Ok<AppUser>(customerUser));
    });

    test('normalizes phone identifiers', () async {
      await LoginUseCase(authRepository)(identifier: '0901 234 567', password: 'p');
      verify(() => authRepository.login(identifier: '0901234567', password: 'p')).called(1);
    });

    test('keeps emails as typed (trimmed)', () async {
      await LoginUseCase(authRepository)(identifier: ' mai@x.vn ', password: 'p');
      verify(() => authRepository.login(identifier: 'mai@x.vn', password: 'p')).called(1);
    });
  });

  test('RegisterUseCase trims name/email and normalizes the phone', () async {
    when(
      () => authRepository.register(
        fullName: any(named: 'fullName'),
        email: any(named: 'email'),
        phone: any(named: 'phone'),
        password: any(named: 'password'),
        role: UserRole.worker,
      ),
    ).thenAnswer((_) async => const Ok<AppUser>(workerUser));

    await RegisterUseCase(authRepository)(
      fullName: ' Trần Văn Hùng ',
      email: ' hung@x.vn ',
      phone: '0909 123 456',
      password: 'p',
      role: UserRole.worker,
    );

    verify(
      () => authRepository.register(
        fullName: 'Trần Văn Hùng',
        email: 'hung@x.vn',
        phone: '0909123456',
        password: 'p',
        role: UserRole.worker,
      ),
    ).called(1);
  });

  test('UpdateProfileUseCase normalizes the phone and trims text', () async {
    when(() => profileRepository.updateProfile(any())).thenAnswer((_) async => const Ok<UserProfile>(customerProfile));

    await UpdateProfileUseCase(profileRepository)(const ProfileUpdate(fullName: ' Mai ', phoneNumber: '0901 234 567'));

    final sent = verify(() => profileRepository.updateProfile(captureAny())).captured.single as ProfileUpdate;
    expect(sent.fullName, 'Mai');
    expect(sent.phoneNumber, '0901234567');
    expect(sent.email, isNull);
  });

  test('UserRole.fromApi maps backend roles', () {
    expect(UserRole.fromApi('CUSTOMER'), UserRole.customer);
    expect(UserRole.fromApi('B2B_CUSTOMER'), UserRole.customer);
    expect(UserRole.fromApi('WORKER'), UserRole.worker);
    expect(UserRole.fromApi('ADMIN'), UserRole.unsupported);
    expect(UserRole.fromApi(null), UserRole.unsupported);
  });

  test('CredentialRules mirror the backend rules', () {
    expect(CredentialRules.isValidEmail('mai@gmail.com'), isTrue);
    expect(CredentialRules.isValidEmail('mai@gmail'), isFalse);
    expect(CredentialRules.isValidEmail('0901234567'), isFalse);
    expect(CredentialRules.isStrongPassword('Password123'), isTrue);
    expect(CredentialRules.isStrongPassword('password123'), isFalse, reason: 'no upper case');
    expect(CredentialRules.isStrongPassword('PASSWORD123'), isFalse, reason: 'no lower case');
    expect(CredentialRules.isStrongPassword('Passwordabc'), isFalse, reason: 'no digit');
    expect(CredentialRules.isStrongPassword('Pass12'), isFalse, reason: 'too short');
    expect(CredentialRules.isValidVietnamesePhone('0901 234 567'), isTrue);
    expect(CredentialRules.isValidVietnamesePhone('+84901234567'), isTrue);
    expect(CredentialRules.isValidVietnamesePhone('0123456789'), isFalse, reason: 'invalid prefix');
    expect(CredentialRules.isValidVietnamesePhone('090123456'), isFalse, reason: 'too short');
    expect(CredentialRules.isValidFullName('A'), isFalse);
    expect(CredentialRules.isValidFullName('An'), isTrue);
    expect(CredentialRules.isValidFullName('a' * 101), isFalse);
  });

  test('UserProfile.initials', () {
    expect(customerProfile.initials, 'NM');
    expect(const UserProfile(id: '1', role: UserRole.customer, fullName: 'mai').initials, 'M');
    expect(const UserProfile(id: '1', role: UserRole.customer).initials, '');
  });
}
