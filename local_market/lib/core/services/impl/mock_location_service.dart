import 'dart:math';
import '../location_service.dart';

enum LocationPermissionState { unknown, loading, granted, denied, unavailable }

/// Robust Location Service implementation supporting Permissions, GPS simulation,
/// Distance calculation, and Manual Location fallback.
class AppLocationService implements LocationService {
  LocationPermissionState _permissionState = LocationPermissionState.unknown;
  String _currentLocationName = 'Beldanga';
  double _currentLatitude = 23.9318;
  double _currentLongitude = 88.2514;

  LocationPermissionState get permissionState => _permissionState;
  String get currentLocationName => _currentLocationName;
  double get currentLatitude => _currentLatitude;
  double get currentLongitude => _currentLongitude;

  @override
  Future<bool> hasLocationPermission() async {
    return _permissionState == LocationPermissionState.granted;
  }

  @override
  Future<bool> requestLocationPermission({
    bool simulateDenied = false,
    bool simulateError = false,
  }) async {
    _permissionState = LocationPermissionState.loading;
    await Future.delayed(const Duration(milliseconds: 800));

    if (simulateError) {
      _permissionState = LocationPermissionState.unavailable;
      return false;
    }

    if (simulateDenied) {
      _permissionState = LocationPermissionState.denied;
      return false;
    }

    _permissionState = LocationPermissionState.granted;
    _currentLocationName = 'Beldanga';
    _currentLatitude = 23.9318;
    _currentLongitude = 88.2514;
    return true;
  }

  @override
  Future<Map<String, double>?> getCurrentCoordinates() async {
    if (_permissionState != LocationPermissionState.granted) {
      return null;
    }
    return {'latitude': _currentLatitude, 'longitude': _currentLongitude};
  }

  void setManualLocation(
    String locationName, {
    double lat = 23.9318,
    double lng = 88.2514,
  }) {
    _currentLocationName = locationName;
    _currentLatitude = lat;
    _currentLongitude = lng;
  }

  @override
  double calculateDistanceInKm(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) {
    const double earthRadiusKm = 6371.0;
    final double dLat = _toRadians(endLat - startLat);
    final double dLng = _toRadians(endLng - startLng);

    final double a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(startLat)) *
            cos(_toRadians(endLat)) *
            sin(dLng / 2) *
            sin(dLng / 2);

    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return double.parse((earthRadiusKm * c).toStringAsFixed(1));
  }

  double _toRadians(double degree) {
    return degree * (pi / 180.0);
  }
}
