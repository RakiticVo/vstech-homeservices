import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_page.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_status.dart';
import 'package:vstech_home_services/features/booking/domain/repositories/booking_repository.dart';

@injectable
class GetMyBookingsUseCase {
  const GetMyBookingsUseCase(this._repository);

  final BookingRepository _repository;

  Future<Result<BookingPage>> call({int page = 0, BookingStatus? status}) =>
      _repository.getMyBookings(page: page, status: status);
}
