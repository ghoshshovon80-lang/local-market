import '../constants/app_constants.dart';

/// Helper utility to format price values for Local Market.
abstract class CurrencyFormatter {
  static String format(double amount) {
    // Return formatted currency e.g. ₹40 or ₹40.50
    if (amount % 1 == 0) {
      return '${AppConstants.currencySymbol}${amount.toInt()}';
    }
    return '${AppConstants.currencySymbol}${amount.toStringAsFixed(2)}';
  }

  static String formatWithUnit(double amount, String unit) {
    return '${format(amount)}/$unit';
  }
}
