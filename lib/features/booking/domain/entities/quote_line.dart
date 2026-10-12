import 'package:flutter/foundation.dart';

/// One extra-cost line a worker adds to a quote.
@immutable
class QuoteLine {
  const QuoteLine({required this.itemName, required this.amount});

  final String itemName;
  final num amount;

  @override
  bool operator ==(Object other) =>
      other is QuoteLine &&
      other.itemName == itemName &&
      other.amount == amount;

  @override
  int get hashCode => Object.hash(itemName, amount);
}

/// `QuoteStatus` (`docs/reference/api/11-appendices.md`); the doc example also uses `PENDING`.
enum QuoteStatus {
  pending,
  approved,
  rejected,
  cancelled;

  static QuoteStatus fromApi(String? value) => switch (value) {
    'APPROVED' => QuoteStatus.approved,
    'REJECTED' => QuoteStatus.rejected,
    'CANCELLED' => QuoteStatus.cancelled,
    _ => QuoteStatus.pending,
  };
}

/// An extra-cost quote sent for a booking. There is no endpoint to read a quote back, so this is
/// what the submit response (plus the lines the worker typed) told us. [submittedAt] is UTC.
@immutable
class SubmittedQuote {
  const SubmittedQuote({
    required this.bookingId,
    required this.status,
    required this.lines,
    required this.totalAmount,
    this.submittedAt,
  });

  final String bookingId;
  final QuoteStatus status;
  final List<QuoteLine> lines;
  final num totalAmount;
  final DateTime? submittedAt;

  @override
  bool operator ==(Object other) =>
      other is SubmittedQuote &&
      other.bookingId == bookingId &&
      other.status == status &&
      listEquals(other.lines, lines) &&
      other.totalAmount == totalAmount &&
      other.submittedAt == submittedAt;

  @override
  int get hashCode => Object.hash(
    bookingId,
    status,
    Object.hashAll(lines),
    totalAmount,
    submittedAt,
  );
}
