/// `TransactionType` (`docs/reference/api/11-appendices.md`).
enum TransactionType {
  deposit,
  commission,
  earning,
  tip,
  withdrawal,
  refund,
  unknown;

  static TransactionType fromApi(String? value) => switch (value) {
    'DEPOSIT' => TransactionType.deposit,
    'COMMISSION' => TransactionType.commission,
    'EARNING' => TransactionType.earning,
    'TIP' => TransactionType.tip,
    'WITHDRAWAL' => TransactionType.withdrawal,
    'REFUND' => TransactionType.refund,
    _ => TransactionType.unknown,
  };

  String get apiValue => name.toUpperCase();

  /// Money coming into the wallet (used when the server sends no signed `delta`).
  bool get isIncoming => switch (this) {
    TransactionType.deposit || TransactionType.earning || TransactionType.tip || TransactionType.refund => true,
    TransactionType.commission || TransactionType.withdrawal || TransactionType.unknown => false,
  };
}

/// `TransactionStatus`.
enum TransactionStatus {
  pending,
  completed,
  failed,
  unknown;

  static TransactionStatus fromApi(String? value) => switch (value) {
    'PENDING' => TransactionStatus.pending,
    'COMPLETED' => TransactionStatus.completed,
    'FAILED' => TransactionStatus.failed,
    _ => TransactionStatus.unknown,
  };

  String get apiValue => name.toUpperCase();
}

/// `WithdrawalStatus`.
enum WithdrawalStatus {
  pendingApproval,
  approved,
  rejected,
  cancelled,
  unknown;

  static WithdrawalStatus fromApi(String? value) => switch (value) {
    'PENDING_APPROVAL' => WithdrawalStatus.pendingApproval,
    'APPROVED' => WithdrawalStatus.approved,
    'REJECTED' => WithdrawalStatus.rejected,
    'CANCELLED' => WithdrawalStatus.cancelled,
    _ => WithdrawalStatus.unknown,
  };
}
