import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/api_endpoints.dart';
import 'package:vstech_home_services/core/network/api_response.dart';
import 'package:vstech_home_services/features/wallet/data/datasources/wallet_remote_data_source.dart';
import 'package:vstech_home_services/features/wallet/data/models/wallet_response.dart';
import 'package:vstech_home_services/features/wallet/data/models/wallet_transaction_response.dart';
import 'package:vstech_home_services/features/wallet/data/models/withdrawal_request_body.dart';
import 'package:vstech_home_services/features/wallet/data/models/withdrawal_response.dart';
import 'package:vstech_home_services/features/wallet/data/repositories/wallet_repository_impl.dart';
import 'package:vstech_home_services/features/wallet/domain/entities/wallet.dart';
import 'package:vstech_home_services/features/wallet/domain/entities/wallet_enums.dart';
import 'package:vstech_home_services/features/wallet/domain/usecases/wallet_use_cases.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../fixtures/wallet/wallet_fixtures.dart';
import '../../../helpers/mocks.dart';

PagedResponse<T> _page<T>(List<T> items, {int pages = 1, int page = 0}) =>
    PagedResponse(content: items, page: page, size: 20, totalItems: items.length, totalPages: pages);

void main() {
  group('WalletRemoteDataSource', () {
    late MockApiClient client;
    late WalletRemoteDataSource dataSource;

    setUp(() {
      client = MockApiClient();
      dataSource = WalletRemoteDataSource(client);
    });

    test('transactions decode both doc and OpenAPI field names; filters are optional', () async {
      when(
        () => client.get<PagedResponse<WalletTransactionResponse>>(
          ApiEndpoints.walletTransactions,
          query: any(named: 'query'),
          decode: any(named: 'decode'),
        ),
      ).thenAnswer((invocation) async {
        final decode = invocation.namedArguments[#decode] as PagedResponse<WalletTransactionResponse> Function(Object?);
        return ApiResponse(
          status: 200,
          message: '',
          data: decode(jsonFixture('wallet/transactions_page.json')['data']),
          errorCode: null,
          timestamp: null,
        );
      });

      final page = await dataSource.getTransactions(page: 0, size: 20, type: 'EARNING');

      expect(page.content.map((t) => t.transactionKey), ['t-1', '42', 't-3']);
      expect(page.content[1].kind, 'WITHDRAWAL');
      expect(page.content.first.amount, 297500);
      verify(
        () => client.get<PagedResponse<WalletTransactionResponse>>(
          ApiEndpoints.walletTransactions,
          query: {'page': 0, 'size': 20, 'type': 'EARNING'},
          decode: any(named: 'decode'),
        ),
      ).called(1);
    });

    test('createWithdrawal is an idempotent POST with the required fields', () async {
      when(
        () => client.post<WithdrawalResponse>(
          ApiEndpoints.withdrawals,
          body: any(named: 'body'),
          idempotent: true,
          decode: any(named: 'decode'),
        ),
      ).thenAnswer(
        (_) async => const ApiResponse(
          status: 200,
          message: '',
          data: WithdrawalResponse(requestId: '9', status: 'PENDING_APPROVAL'),
          errorCode: null,
          timestamp: null,
        ),
      );

      final result = await dataSource.createWithdrawal(
        const WithdrawalRequestBody(amount: 500000, bankCode: 'VCB', bankAccountNumber: '123'),
      );

      expect(result.withdrawalKey, '9');
      verify(
        () => client.post<WithdrawalResponse>(
          ApiEndpoints.withdrawals,
          body: {'amount': 500000, 'bankCode': 'VCB', 'bankAccountNumber': '123'},
          idempotent: true,
          decode: any(named: 'decode'),
        ),
      ).called(1);
    });
  });

  group('WalletRepositoryImpl', () {
    late MockWalletRemoteDataSource remote;
    late WalletRepositoryImpl repository;

    setUpAll(() => registerFallbackValue(const WithdrawalRequestBody(amount: 0, bankCode: '', bankAccountNumber: '')));

    setUp(() {
      remote = MockWalletRemoteDataSource();
      repository = WalletRepositoryImpl(remote);
    });

    test('getWallet maps balances with safe defaults', () async {
      when(() => remote.getWallet()).thenAnswer((_) async => const WalletResponse(balance: 100, currency: 'VND'));

      final result = await repository.getWallet();

      expect((result as Ok<Wallet>).value, const Wallet(balance: 100));
    });

    test('transactions derive a signed delta from the type when it is missing, and are cached', () async {
      when(() => remote.getTransactions(page: 0, size: 20)).thenAnswer(
        (_) async => _page(const [
          WalletTransactionResponse(transactionId: '42', txType: 'WITHDRAWAL', amount: 2000000),
          WalletTransactionResponse(id: 't-1', type: 'EARNING', amount: 1000),
        ]),
      );

      final result = await repository.getTransactions(page: 0);

      final items = (result as Ok<WalletPage<WalletTransaction>>).value.items;
      expect(items.first.delta, -2000000);
      expect(items.last.delta, 1000);
      expect(repository.cachedTransaction('42')?.type, TransactionType.withdrawal);
    });

    test('withdrawals map status and rejection reason from either field', () async {
      when(() => remote.getWithdrawals(page: 0, size: 20)).thenAnswer(
        (_) async => _page(const [
          WithdrawalResponse(requestId: '5', amount: 100, status: 'REJECTED', rejectionReason: 'Sai số tài khoản'),
        ]),
      );

      final result = await repository.getWithdrawals(page: 0);

      final withdrawal = (result as Ok<WalletPage<Withdrawal>>).value.items.single;
      expect(withdrawal.status, WithdrawalStatus.rejected);
      expect(withdrawal.reason, 'Sai số tài khoản');
      expect(repository.cachedWithdrawal('5'), withdrawal);
    });
  });

  group('wallet use cases', () {
    late MockWalletRepository repository;

    setUp(() => repository = MockWalletRepository());

    test('CreateWithdrawalUseCase rejects amounts above the balance (HS-400-0020)', () async {
      final result = await CreateWithdrawalUseCase(repository)(
        amount: 5000000,
        bankCode: 'vcb',
        bankAccountNumber: '123',
        availableBalance: 4860000,
      );

      expect(result, isA<Err<Withdrawal>>().having((r) => r.failure.errorCode, 'code', 'HS-400-0020'));
    });

    test('CreateWithdrawalUseCase rejects missing bank details (HS-400-0001)', () async {
      final result = await CreateWithdrawalUseCase(repository)(amount: 100, bankCode: ' ', bankAccountNumber: '123');

      expect(result, isA<Err<Withdrawal>>().having((r) => r.failure.errorCode, 'code', 'HS-400-0001'));
    });

    test('CreateWithdrawalUseCase normalises bank code and account number', () async {
      when(
        () => repository.createWithdrawal(
          amount: any(named: 'amount'),
          bankCode: any(named: 'bankCode'),
          bankAccountNumber: any(named: 'bankAccountNumber'),
        ),
      ).thenAnswer((_) async => Ok(pendingWithdrawal));

      await CreateWithdrawalUseCase(repository)(amount: 500000, bankCode: ' vcb ', bankAccountNumber: '1234 5678');

      verify(() => repository.createWithdrawal(amount: 500000, bankCode: 'VCB', bankAccountNumber: '12345678'))
          .called(1);
    });

    test('GetWithdrawalUseCase uses the cache, then the list, then reports HS-404-0021', () async {
      when(() => repository.cachedWithdrawal('w-1')).thenReturn(pendingWithdrawal);
      expect(await GetWithdrawalUseCase(repository)('w-1'), isA<Ok<Withdrawal>>());

      when(() => repository.cachedWithdrawal('x')).thenReturn(null);
      when(() => repository.getWithdrawals(page: 0))
          .thenAnswer((_) async => Ok(WalletPage(items: [pendingWithdrawal], page: 0, hasMore: false)));
      final missing = await GetWithdrawalUseCase(repository)('x');
      expect(missing, isA<Err<Withdrawal>>().having((r) => r.failure.errorCode, 'code', 'HS-404-0021'));
    });
  });
}
