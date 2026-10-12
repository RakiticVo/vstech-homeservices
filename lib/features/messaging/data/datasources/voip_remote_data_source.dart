import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/network/api_client.dart';
import 'package:vstech_home_services/core/network/api_endpoints.dart';
import 'package:vstech_home_services/features/messaging/data/models/end_call_request.dart';
import 'package:vstech_home_services/features/messaging/data/models/start_call_request.dart';
import 'package:vstech_home_services/features/messaging/data/models/voip_call_response.dart';

/// `/api/v1/voip/calls*` — the call log only; audio itself is not handled by this API.
@injectable
class VoipRemoteDataSource {
  const VoipRemoteDataSource(this._client);

  final ApiClient _client;

  Future<VoipCallResponse> startCall(StartCallRequest body) async {
    final response = await _client.post(
      ApiEndpoints.voipCalls,
      body: body.toJson(),
      idempotent: true,
      decode: (json) =>
          VoipCallResponse.fromJson(json! as Map<String, dynamic>),
    );
    return response.requireData;
  }

  Future<VoipCallResponse> endCall(EndCallRequest body) async {
    final response = await _client.post(
      ApiEndpoints.voipCallsEnd,
      body: body.toJson(),
      idempotent: true,
      decode: (json) =>
          VoipCallResponse.fromJson(json! as Map<String, dynamic>),
    );
    return response.requireData;
  }

  Future<List<VoipCallResponse>> getCalls({String? bookingId}) async {
    final response = await _client.get(
      ApiEndpoints.voipCalls,
      query: {'bookingId': ?bookingId},
      decode: (json) => [
        for (final item in (json as List<Object?>?) ?? const [])
          VoipCallResponse.fromJson(item! as Map<String, dynamic>),
      ],
    );
    return response.data ?? const [];
  }
}
