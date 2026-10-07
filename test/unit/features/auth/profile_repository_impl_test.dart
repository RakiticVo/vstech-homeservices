import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/core/session/user_role.dart';
import 'package:vstech_home_services/features/auth/data/models/user_profile_response.dart';
import 'package:vstech_home_services/features/auth/data/models/user_profile_update_request.dart';
import 'package:vstech_home_services/features/auth/data/repositories/profile_repository_impl.dart';
import 'package:vstech_home_services/features/auth/domain/entities/profile_update.dart';
import 'package:vstech_home_services/features/auth/domain/entities/user_profile.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../helpers/mocks.dart';

UserProfileResponse _response(String path) =>
    UserProfileResponse.fromJson(jsonFixture(path)['data'] as Map<String, dynamic>);

void main() {
  late MockProfileRemoteDataSource remote;
  late ProfileRepositoryImpl repository;

  setUpAll(() => registerFallbackValue(const UserProfileUpdateRequest()));

  setUp(() {
    remote = MockProfileRemoteDataSource();
    repository = ProfileRepositoryImpl(remote);
  });

  test('maps a worker profile, preferring metrics rating', () async {
    when(() => remote.getProfile()).thenAnswer((_) async => _response('auth/profile_worker.json'));

    final result = await repository.getProfile();

    final profile = (result as Ok<UserProfile>).value;
    expect(profile.role, UserRole.worker);
    expect(profile.rating, 4.9);
    expect(profile.completedJobs, 118);
    expect(profile.kycApprovalStatus, 'APPROVED');
    expect(profile.initials, 'TH');
    expect(profile.isVerified, isTrue, reason: 'KYC approved');
    expect(profile.skillCount, 1);
    expect(profile.verifiedSkillCount, 1);
  });

  test('maps the customer default address', () async {
    when(() => remote.getProfile()).thenAnswer((_) async => _response('auth/profile_customer.json'));

    final profile = ((await repository.getProfile()) as Ok<UserProfile>).value;

    expect(profile.role, UserRole.customer);
    expect(profile.defaultAddress, '123 Nguyễn Thị Minh Khai, Quận 1');
    expect(profile.lat, 10.77);
    expect(profile.isVerified, isFalse);
  });

  test('update forwards only the provided fields', () async {
    when(() => remote.updateProfile(any())).thenAnswer((_) async => _response('auth/profile_customer.json'));

    await repository.updateProfile(const ProfileUpdate(defaultAddress: 'Q1'));

    verify(() => remote.updateProfile(const UserProfileUpdateRequest(defaultAddress: 'Q1'))).called(1);
  });

  test('errors become failures', () async {
    when(() => remote.getProfile()).thenThrow(const NetworkException(kind: NetworkErrorKind.timeout));

    final result = await repository.getProfile();

    expect(result, isA<Err<UserProfile>>().having((r) => r.failure.kind, 'kind', NetworkErrorKind.timeout));
  });
}
