import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/booking/domain/repositories/booking_repository.dart';

/// Customer decision on a worker's extra-cost quote. UI arrives with Claude Design Batch 14.
@injectable
class ApproveQuoteUseCase {
  const ApproveQuoteUseCase(this._repository);

  final BookingRepository _repository;

  Future<Result<void>> call(String bookingId) => _repository.approveQuote(bookingId);
}

@injectable
class RejectQuoteUseCase {
  const RejectQuoteUseCase(this._repository);

  final BookingRepository _repository;

  Future<Result<void>> call(String bookingId) => _repository.rejectQuote(bookingId);
}
