import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/location/location_service.dart';
import 'package:vstech_home_services/core/network/api_endpoints.dart';
import 'package:vstech_home_services/core/network/api_response.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/features/tracking/data/datasources/technician_location_remote_data_source.dart';
import 'package:vstech_home_services/features/tracking/data/models/location_update_request.dart';
import 'package:vstech_home_services/features/tracking/data/repositories/technician_location_repository_impl.dart';

import '../../../helpers/mocks.dart';

void main() {
  test('datasource PUTs latitude/longitude without technicianId (server ignores it)', () async {
    final client = MockApiClient();
    when(
      () => client.put<Object?>(
        ApiEndpoints.technicianLocation,
        body: any(named: 'body'),
        decode: any(named: 'decode'),
      ),
    ).thenAnswer(
      (_) async => const ApiResponse(status: 200, message: '', data: null, errorCode: null, timestamp: null),
    );

    await TechnicianLocationRemoteDataSource(client)
        .update(const LocationUpdateRequest(latitude: 10.7, longitude: 106.6));

    verify(
      () => client.put<Object?>(
        ApiEndpoints.technicianLocation,
        body: {'latitude': 10.7, 'longitude': 106.6},
        decode: any(named: 'decode'),
      ),
    ).called(1);
  });

  test('repository maps the position and errors', () async {
    final remote = MockTechnicianLocationRemoteDataSource();
    registerFallbackValue(const LocationUpdateRequest(latitude: 0, longitude: 0));
    when(() => remote.update(any())).thenAnswer((_) async {});

    final ok = await TechnicianLocationRepositoryImpl(remote).update(const GeoPoint(10.7, 106.6));
    expect(ok, isA<Ok<void>>());
    verify(() => remote.update(const LocationUpdateRequest(latitude: 10.7, longitude: 106.6))).called(1);

    when(() => remote.update(any())).thenThrow(const NetworkException(kind: NetworkErrorKind.noConnection));
    final err = await TechnicianLocationRepositoryImpl(remote).update(const GeoPoint(1, 1));
    expect(err, isA<Err<void>>());
  });
}
