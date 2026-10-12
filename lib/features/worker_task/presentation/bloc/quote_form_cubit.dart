import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/booking/domain/entities/quote_line.dart';
import 'package:vstech_home_services/features/booking/domain/usecases/get_booking_use_case.dart';
import 'package:vstech_home_services/features/booking/domain/usecases/worker_booking_use_cases.dart';
import 'package:vstech_home_services/features/home/domain/usecases/get_category_use_case.dart';

part 'quote_form_state.dart';

/// Worker's extra-cost quote form (design Cell 132): 1–10 line items, live total, the 1.5 × estimate
/// cap, then `POST /bookings/{id}/quote`. Photos are not offered — there is no upload API yet.
@injectable
class QuoteFormCubit extends Cubit<QuoteFormState> {
  QuoteFormCubit(this._getBooking, this._getCategory, this._submitQuote)
    : super(const QuoteFormLoadingState());

  final GetBookingUseCase _getBooking;
  final GetCategoryUseCase _getCategory;
  final SubmitQuoteUseCase _submitQuote;

  int _nextLineId = 0;

  Future<void> load(String bookingId) async {
    emit(const QuoteFormLoadingState());
    switch (await _getBooking(bookingId)) {
      case Err(:final failure):
        emit(QuoteFormLoadErrorState(failure));
      case Ok(value: final booking):
        final categoryId = booking.categoryId;
        final serviceName = categoryId == null
            ? null
            : switch (await _getCategory(categoryId)) {
                Ok(:final value) => value.name,
                Err() => null,
              };
        emit(
          QuoteFormEditingState(
            bookingId: booking.id,
            serviceName: serviceName,
            estimatedPrice: booking.estimatedPrice,
            lines: [QuoteDraftLine(id: _nextLineId++)],
          ),
        );
    }
  }

  void addLine() => _edit((s) {
    if (s.lines.length >= SubmitQuoteUseCase.maxLines) return s;
    return s.copyWith(
      lines: [
        ...s.lines,
        QuoteDraftLine(id: _nextLineId++),
      ],
    );
  });

  void removeLine(int lineId) => _edit((s) {
    if (s.lines.length <= 1) return s;
    return s.copyWith(
      lines: [
        for (final l in s.lines)
          if (l.id != lineId) l,
      ],
    );
  });

  void updateName(int lineId, String name) => _edit(
    (s) => s.copyWith(
      lines: [
        for (final l in s.lines)
          if (l.id == lineId) l.copyWith(name: name) else l,
      ],
    ),
  );

  /// [amountText] is whatever the field holds; only its digits count ("45.000" → 45000).
  void updateAmount(int lineId, String amountText) {
    final digits = amountText.replaceAll(RegExp('[^0-9]'), '');
    final amount = digits.isEmpty ? null : num.parse(digits);
    _edit(
      (s) => s.copyWith(
        lines: [
          for (final l in s.lines)
            if (l.id == lineId)
              l.copyWith(amount: amount, clearAmount: amount == null)
            else
              l,
        ],
      ),
    );
  }

  /// Validates (showing field errors from now on) and sends the quote when everything is valid.
  Future<void> submit() async {
    final current = state;
    if (current is! QuoteFormEditingState ||
        current.isSending ||
        !current.hasInput) {
      return;
    }
    if (!current.isValid) {
      emit(current.copyWith(showErrors: true));
      return;
    }
    emit(current.copyWith(showErrors: true, isSending: true));
    final result = await _submitQuote(current.bookingId, [
      for (final l in current.lines)
        QuoteLine(itemName: l.name, amount: l.amount!),
    ], estimatedPrice: current.estimatedPrice);
    switch (result) {
      case Ok(:final value):
        emit(current.copyWith(showErrors: true, submitted: value));
      case Err(:final failure):
        emit(current.copyWith(showErrors: true, failure: failure));
    }
  }

  void _edit(QuoteFormEditingState Function(QuoteFormEditingState) change) {
    final current = state;
    if (current is! QuoteFormEditingState ||
        current.isSending ||
        current.submitted != null) {
      return;
    }
    final next = change(current);
    if (next != current) emit(next);
  }
}
