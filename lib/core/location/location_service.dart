import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/utils/logger.dart';

/// A WGS84 coordinate.
@immutable
class GeoPoint {
  const GeoPoint(this.lat, this.lng);

  final double lat;
  final double lng;

  @override
  bool operator ==(Object other) => other is GeoPoint && other.lat == lat && other.lng == lng;

  @override
  int get hashCode => Object.hash(lat, lng);
}

/// Why the current position could not be read.
enum LocationFailure { serviceDisabled, permissionDenied, unavailable }

/// Current-position lookup behind an interface so blocs can be tested without a device.
abstract interface class LocationService {
  /// Asks for permission when needed. Returns the position or the reason it is unavailable.
  Future<(GeoPoint?, LocationFailure?)> currentPosition();
}

@LazySingleton(as: LocationService)
class GeolocatorLocationService implements LocationService {
  const GeolocatorLocationService();

  @override
  Future<(GeoPoint?, LocationFailure?)> currentPosition() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return (null, LocationFailure.serviceDisabled);
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        return (null, LocationFailure.permissionDenied);
      }
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(timeLimit: Duration(seconds: 15)),
      );
      return (GeoPoint(position.latitude, position.longitude), null);
    } on Object catch (e) {
      appLogger.w('Could not read the current position', error: e);
      return (null, LocationFailure.unavailable);
    }
  }
}
