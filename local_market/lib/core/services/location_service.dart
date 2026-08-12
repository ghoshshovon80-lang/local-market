/// Location Service Interface for geographic coordinates and permissions.
abstract class LocationService {
  Future<bool> requestLocationPermission();
  Future<bool> hasLocationPermission();
  Future<Map<String, double>?> getCurrentCoordinates();
  double calculateDistanceInKm(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  );
}
