import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/location/location_service.dart';

abstract interface class TechnicianLocationRepository {
  /// Reports the signed-in worker's position.
  Future<Result<void>> update(GeoPoint position);
}
