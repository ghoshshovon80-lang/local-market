import 'dart:async';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import '../location_service.dart';

enum RealLocationPermissionStatus {
  unknown,
  loading,
  granted,
  denied,
  deniedForever,
  serviceDisabled,
  error,
}

/// Real Device GPS & Location Permission Service using Geolocator plugin
class RealLocationService implements LocationService {
  RealLocationPermissionStatus _status = RealLocationPermissionStatus.unknown;
  String _currentLocationName = 'Beldanga';
  double? _currentLatitude;
  double? _currentLongitude;

  RealLocationPermissionStatus get status => _status;
  String get currentLocationName => _currentLocationName;
  double? get currentLatitude => _currentLatitude;
  double? get currentLongitude => _currentLongitude;

  @override
  Future<bool> hasLocationPermission() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  @override
  Future<bool> requestLocationPermission() async {
    _status = RealLocationPermissionStatus.loading;

    try {
      // 1. Check if device location services (GPS) are enabled
      final isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isServiceEnabled) {
        _status = RealLocationPermissionStatus.serviceDisabled;
        return false;
      }

      // 2. Check current OS permission status
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        _status = RealLocationPermissionStatus.denied;
        return false;
      }

      if (permission == LocationPermission.deniedForever) {
        _status = RealLocationPermissionStatus.deniedForever;
        return false;
      }

      // 3. Permission Granted: Obtain real device position
      _status = RealLocationPermissionStatus.granted;

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      _currentLatitude = position.latitude;
      _currentLongitude = position.longitude;
      _currentLocationName =
          'GPS (${position.latitude.toStringAsFixed(3)}, ${position.longitude.toStringAsFixed(3)})';

      return true;
    } catch (e) {
      if (_status != RealLocationPermissionStatus.granted) {
        _status = RealLocationPermissionStatus.error;
      }
      return false;
    }
  }

  @override
  Future<Map<String, double>?> getCurrentCoordinates() async {
    if (_currentLatitude != null && _currentLongitude != null) {
      return {'latitude': _currentLatitude!, 'longitude': _currentLongitude!};
    }
    return null;
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
