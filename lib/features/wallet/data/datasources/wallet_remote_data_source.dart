import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/network/api_client.dart';
import 'package:vstech_home_services/core/network/api_endpoints.dart';
import 'package:vstech_home_services/core/network/api_response.dart';
import 'package:vstech_home_services/features/wallet/data/models/wallet_response.dart';
import 'package:vstech_home_services/features/wallet/data/models/wallet_transaction_response.dart';
import 'package:vstech_home_services/features/wallet/data/models/withdrawal_request_body.dart';
import 'package:vstech_home_services/features/wallet/data/models/withdrawal_response.dart';

/// `/api/v1/wallets/*` — the signed-in user's wallet and withdrawal requests.
@injectable
class WalletRemoteDataSource {
  const WalletRemoteDataSource(this._client);

  final ApiClient _client;

  Future<WalletResponse> getWallet() async {
    final response = await _client.get(
      ApiEndpoints.walletMe,
      decode: (json) => WalletResponse.fromJson(json! as Map<String, dynamic>),
    );
    return response.requireData;
  }

  Future<PagedResponse<WalletTransactionResponse>> getTransactions({
    required int page,
    required int size,
    String? type,
    String? status,
  }) async {
    final response = await _client.get(
      ApiEndpoints.walletTransactions,
      query: {'page': page, 'size': size, 'type': ?type, 'status': ?status},
      decode: (json) => PagedResponse.fromJson(
        json! as Map<String, dynamic>,
        (item) => WalletTransactionResponse.fromJson(item! as Map<String, dynamic>),
      ),
    );
    return response.requireData;
  }

  Future<WithdrawalResponse> createWithdrawal(WithdrawalRequestBody body) async {
    final response = await _client.post(
      ApiEndpoints.withdrawals,
      body: body.toJson(),
      idempotent: true,
      decode: (json) => WithdrawalResponse.fromJson(json! as Map<String, dynamic>),
    );
    return response.requireData;
  }

  Future<PagedResponse<WithdrawalResponse>> getWithdrawals({required int page, required int size}) async {
    final response = await _client.get(
      ApiEndpoints.withdrawals,
      query: {'page': page, 'size': size},
      decode: (json) => PagedResponse.fromJson(
        json! as Map<String, dynamic>,
        (item) => WithdrawalResponse.fromJson(item! as Map<String, dynamic>),
      ),
    );
    return response.requireData;
  }
}
