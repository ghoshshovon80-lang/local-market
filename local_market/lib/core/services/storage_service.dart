/// Local Storage Service Interface for persistent key-value preferences.
abstract class StorageService {
  Future<void> setString(String key, String value);
  String? getString(String key);
  Future<void> setBool(String key, bool value);
  bool? getBool(String key);
  Future<void> remove(String key);
  Future<void> clear();
}
