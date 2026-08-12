/// Application-wide constant configuration values for Local Market.
abstract class AppConstants {
  static const String appName = 'Local Market';
  static const String appTagline = 'Your Local Shops. Your Choice.';
  static const String appVersion = '1.0.0';

  // Order & Financial Rules
  /// Default delivery fee for MVP (Configurable value, not hardcoded logic)
  static const double defaultDeliveryFee = 10.0;
  static const String currencySymbol = '₹';

  // Layout & UI Constants
  static const double defaultPadding = 16.0;
  static const double cardRadius = 12.0;
  static const double buttonRadius = 10.0;
  static const double inputRadius = 8.0;

  // Search & Filter Defaults
  static const double defaultSearchRadiusKm = 5.0;
}
