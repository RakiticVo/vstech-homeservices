import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_status.dart';
import 'package:vstech_home_services/features/booking/domain/entities/quote_line.dart';
import 'package:vstech_home_services/features/booking/domain/repositories/booking_repository.dart';

/// Worker side of the booking state machine (PENDING → ACCEPTED → IN_PROGRESS → COMPLETED).

@injectable
class AcceptBookingUseCase {
  const AcceptBookingUseCase(this._repository);

  final BookingRepository _repository;

  Future<Result<BookingStatus>> call(String bookingId) => _repository.accept(bookingId);
}

@injectable
class StartBookingUseCase {
  const StartBookingUseCase(this._repository);

  final BookingRepository _repository;

  Future<Result<BookingStatus>> call(String bookingId) => _repository.start(bookingId);
}

@injectable
class CompleteBookingUseCase {
  const CompleteBookingUseCase(this._repository);

  final BookingRepository _repository;

  /// Upper bound the backend enforces on `actualPrice` (`HS-400-0012`).
  static const double maxPriceFactor = 1.5;

  /// Rejects an [actualPrice] above 1.5 × [estimatedPrice] locally with the server's code.
  Future<Result<BookingStatus>> call(String bookingId, {required num actualPrice, num? estimatedPrice}) async {
    if (actualPrice <= 0 || (estimatedPrice != null && actualPrice > estimatedPrice * maxPriceFactor)) {
      return const Err(Failure(kind: NetworkErrorKind.unknown, errorCode: 'HS-400-0012'));
    }
    return await _repository.complete(bookingId, actualPrice: actualPrice);
  }
}

@injectable
class SubmitQuoteUseCase {
  const SubmitQuoteUseCase(this._repository);

  final BookingRepository _repository;

  /// Requires at least one line, each with a name and a positive amount (`HS-400-0001` otherwise).
  Future<Result<void>> call(String bookingId, List<QuoteLine> lines) async {
    final valid = lines.isNotEmpty && lines.every((line) => line.itemName.trim().isNotEmpty && line.amount > 0);
    if (!valid) return const Err(Failure(kind: NetworkErrorKind.unknown, errorCode: 'HS-400-0001'));
    return await _repository.submitQuote(bookingId, [
      for (final line in lines) QuoteLine(itemName: line.itemName.trim(), amount: line.amount),
    ]);
  }
}
