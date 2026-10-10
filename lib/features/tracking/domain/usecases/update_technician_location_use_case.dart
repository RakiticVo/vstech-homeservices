import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/location/location_service.dart';
import 'package:vstech_home_services/features/tracking/domain/repositories/technician_location_repository.dart';

@injectable
class UpdateTechnicianLocationUseCase {
  const UpdateTechnicianLocationUseCase(this._repository);

  final TechnicianLocationRepository _repository;

  Future<Result<void>> call(GeoPoint position) => _repository.update(position);
}
