import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/location/location_service.dart';
import 'package:vstech_home_services/features/tracking/data/datasources/technician_location_remote_data_source.dart';
import 'package:vstech_home_services/features/tracking/data/models/location_update_request.dart';
import 'package:vstech_home_services/features/tracking/domain/repositories/technician_location_repository.dart';

@LazySingleton(as: TechnicianLocationRepository)
class TechnicianLocationRepositoryImpl implements TechnicianLocationRepository {
  const TechnicianLocationRepositoryImpl(this._remote);

  final TechnicianLocationRemoteDataSource _remote;

  @override
  Future<Result<void>> update(GeoPoint position) =>
      Result.guard(() => _remote.update(LocationUpdateRequest(latitude: position.lat, longitude: position.lng)));
}
