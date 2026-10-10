import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/booking/domain/entities/price_estimate.dart';
import 'package:vstech_home_services/features/booking/domain/repositories/booking_repository.dart';

@injectable
class EstimatePriceUseCase {
  const EstimatePriceUseCase(this._repository);

  final BookingRepository _repository;

  Future<Result<PriceEstimate>> call({required String categoryId, required String description}) =>
      _repository.estimate(categoryId: categoryId, description: description.trim());
}
