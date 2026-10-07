import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/network/api_endpoints.dart';
import 'package:vstech_home_services/core/network/api_response.dart';
import 'package:vstech_home_services/features/auth/data/datasources/profile_remote_data_source.dart';
import 'package:vstech_home_services/features/auth/data/models/user_profile_response.dart';
import 'package:vstech_home_services/features/auth/data/models/user_profile_update_request.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../helpers/mocks.dart';

ApiResponse<UserProfileResponse> _envelope(Invocation invocation, String fixturePath) {
  final decode = invocation.namedArguments[#decode] as UserProfileResponse Function(Object?);
  return ApiResponse(
    status: 200,
    message: '',
    data: decode(jsonFixture(fixturePath)['data']),
    errorCode: null,
    timestamp: null,
  );
}

void main() {
  late MockApiClient client;
  late ProfileRemoteDataSource dataSource;

  setUp(() {
    client = MockApiClient();
    dataSource = ProfileRemoteDataSource(client);
  });

  test('getProfile decodes nested worker data', () async {
    when(() => client.get<UserProfileResponse>(ApiEndpoints.profiles, decode: any(named: 'decode')))
        .thenAnswer((invocation) async => _envelope(invocation, 'auth/profile_worker.json'));

    final profile = await dataSource.getProfile();

    expect(profile.fullName, 'Trần Văn Hùng');
    expect(profile.workerMetrics?.averageRating, 4.9);
    expect(profile.workerKyc?.approvalStatus, 'APPROVED');
    expect(profile.workerSkills.single.experienceYears, 5);
  });

  test('getProfile tolerates missing optional blocks', () async {
    when(() => client.get<UserProfileResponse>(ApiEndpoints.profiles, decode: any(named: 'decode')))
        .thenAnswer((invocation) async => _envelope(invocation, 'auth/profile_customer.json'));

    final profile = await dataSource.getProfile();

    expect(profile.userProfile?.defaultAddress, '123 Nguyễn Thị Minh Khai, Quận 1');
    expect(profile.workerSkills, isEmpty);
    expect(profile.workerMetrics, isNull);
  });

  test('updateProfile sends only the changed fields', () async {
    when(
      () => client.put<UserProfileResponse>(
        ApiEndpoints.profiles,
        body: any(named: 'body'),
        decode: any(named: 'decode'),
      ),
    ).thenAnswer((invocation) async => _envelope(invocation, 'auth/profile_customer.json'));

    await dataSource.updateProfile(const UserProfileUpdateRequest(fullName: 'Mai', defaultAddress: 'Q1'));

    verify(
      () => client.put<UserProfileResponse>(
        ApiEndpoints.profiles,
        body: {'fullName': 'Mai', 'defaultAddress': 'Q1'},
        decode: any(named: 'decode'),
      ),
    ).called(1);
  });
}
