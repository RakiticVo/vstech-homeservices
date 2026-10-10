import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/network/api_client.dart';
import 'package:vstech_home_services/core/network/api_endpoints.dart';
import 'package:vstech_home_services/features/tracking/data/models/location_update_request.dart';

@injectable
class TechnicianLocationRemoteDataSource {
  const TechnicianLocationRemoteDataSource(this._client);

  final ApiClient _client;

  Future<void> update(LocationUpdateRequest request) =>
      _client.put<Object?>(ApiEndpoints.technicianLocation, body: request.toJson(), decode: (json) => json);
}
