part of 'quote_form_cubit.dart';

/// One line being typed. [id] is stable so the UI can keep its text fields across removals.
@immutable
class QuoteDraftLine {
  const QuoteDraftLine({required this.id, this.name = '', this.amount});

  final int id;
  final String name;
  final num? amount;

  bool get hasName => name.trim().isNotEmpty;

  bool get hasValidAmount => (amount ?? 0) > 0;

  bool get isEmpty => !hasName && amount == null;

  QuoteDraftLine copyWith({
    String? name,
    num? amount,
    bool clearAmount = false,
  }) => QuoteDraftLine(
    id: id,
    name: name ?? this.name,
    amount: clearAmount ? null : amount ?? this.amount,
  );

  @override
  bool operator ==(Object other) =>
      other is QuoteDraftLine &&
      other.id == id &&
      other.name == name &&
      other.amount == amount;

  @override
  int get hashCode => Object.hash(id, name, amount);
}

@immutable
sealed class QuoteFormState {
  const QuoteFormState();
}

final class QuoteFormLoadingState extends QuoteFormState {
  const QuoteFormLoadingState();
}

final class QuoteFormLoadErrorState extends QuoteFormState {
  const QuoteFormLoadErrorState(this.failure);

  final Failure failure;

  @override
  bool operator ==(Object other) =>
      other is QuoteFormLoadErrorState && other.failure == failure;

  @override
  int get hashCode => failure.hashCode;
}

final class QuoteFormEditingState extends QuoteFormState {
  const QuoteFormEditingState({
    required this.bookingId,
    required this.lines,
    this.serviceName,
    this.estimatedPrice,
    this.showErrors = false,
    this.isSending = false,
    this.failure,
    this.submitted,
  });

  final String bookingId;
  final String? serviceName;
  final num? estimatedPrice;
  final List<QuoteDraftLine> lines;

  /// Field errors are only shown after the first send attempt.
  final bool showErrors;
  final bool isSending;

  /// One-shot failure of the last send, shown as a SnackBar.
  final Failure? failure;

  /// Set once the server accepted the quote — the screen closes.
  final SubmittedQuote? submitted;

  num get total => lines.fold<num>(0, (sum, line) => sum + (line.amount ?? 0));

  /// Highest order total allowed (1.5 × estimate), or null without an estimate.
  num? get cap => SubmitQuoteUseCase.capFor(estimatedPrice);

  /// Estimate + this quote.
  num get orderTotal => (estimatedPrice ?? 0) + total;

  bool get exceedsCap => SubmitQuoteUseCase.exceedsCap(
    estimatedPrice: estimatedPrice,
    extra: total,
  );

  bool get canAddLine => lines.length < SubmitQuoteUseCase.maxLines;

  /// The send button stays disabled until something has been typed.
  bool get hasInput => lines.any((line) => !line.isEmpty);

  bool get isValid =>
      lines.every((line) => line.hasName && line.hasValidAmount) && !exceedsCap;

  /// Clears [failure] unless a new one is passed; [isSending] resets to false unless passed.
  QuoteFormEditingState copyWith({
    List<QuoteDraftLine>? lines,
    bool? showErrors,
    bool isSending = false,
    Failure? failure,
    SubmittedQuote? submitted,
  }) => QuoteFormEditingState(
    bookingId: bookingId,
    serviceName: serviceName,
    estimatedPrice: estimatedPrice,
    lines: lines ?? this.lines,
    showErrors: showErrors ?? this.showErrors,
    isSending: isSending,
    failure: failure,
    submitted: submitted ?? this.submitted,
  );

  @override
  bool operator ==(Object other) =>
      other is QuoteFormEditingState &&
      other.bookingId == bookingId &&
      other.serviceName == serviceName &&
      other.estimatedPrice == estimatedPrice &&
      listEquals(other.lines, lines) &&
      other.showErrors == showErrors &&
      other.isSending == isSending &&
      other.failure == failure &&
      other.submitted == submitted;

  @override
  int get hashCode => Object.hash(
    bookingId,
    serviceName,
    estimatedPrice,
    Object.hashAll(lines),
    showErrors,
    isSending,
    failure,
    submitted,
  );
}
