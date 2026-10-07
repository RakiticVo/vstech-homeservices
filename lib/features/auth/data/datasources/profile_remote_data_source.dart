import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/network/api_client.dart';
import 'package:vstech_home_services/core/network/api_endpoints.dart';
import 'package:vstech_home_services/features/auth/data/models/user_profile_response.dart';
import 'package:vstech_home_services/features/auth/data/models/user_profile_update_request.dart';

/// `/api/v1/profiles` — the signed-in user's own profile.
@injectable
class ProfileRemoteDataSource {
  const ProfileRemoteDataSource(this._client);

  final ApiClient _client;

  Future<UserProfileResponse> getProfile() async {
    final response = await _client.get(ApiEndpoints.profiles, decode: _decode);
    return response.requireData;
  }

  Future<UserProfileResponse> updateProfile(UserProfileUpdateRequest request) async {
    final response = await _client.put(ApiEndpoints.profiles, body: request.toJson(), decode: _decode);
    return response.requireData;
  }

  static UserProfileResponse _decode(Object? json) => UserProfileResponse.fromJson(json! as Map<String, dynamic>);
}
