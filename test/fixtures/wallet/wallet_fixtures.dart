import 'package:vstech_home_services/features/wallet/domain/entities/wallet.dart';
import 'package:vstech_home_services/features/wallet/domain/entities/wallet_enums.dart';

const wallet = Wallet(balance: 4860000, frozenBalance: 340000);

final earning = WalletTransaction(
  id: 't-1',
  type: TransactionType.earning,
  status: TransactionStatus.completed,
  amount: 297500,
  delta: 297500,
  description: 'Thu nhập đơn #501',
  referenceRequestId: '501',
  createdAt: DateTime.utc(2030, 1, 2, 8),
);

final withdrawalTx = WalletTransaction(
  id: '42',
  type: TransactionType.withdrawal,
  status: TransactionStatus.pending,
  amount: 2000000,
  delta: -2000000,
  createdAt: DateTime.utc(2030, 1, 1, 8),
);

final pendingWithdrawal = Withdrawal(
  id: 'w-1',
  amount: 500000,
  status: WithdrawalStatus.pendingApproval,
  bankCode: 'VCB',
  bankAccountNumber: '1234567890',
  createdAt: DateTime.utc(2030, 1, 2, 8),
);
