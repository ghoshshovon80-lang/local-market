import 'package:url_launcher/url_launcher.dart';

abstract class MapNavigationService {
  Future<bool> openDirections({
    required double latitude,
    required double longitude,
    required String shopName,
  });

  Future<bool> makePhoneCall({required String phoneNumber});
}

class AppMapNavigationService implements MapNavigationService {
  @override
  Future<bool> openDirections({
    required double latitude,
    required double longitude,
    required String shopName,
  }) async {
    final encodedName = Uri.encodeComponent(shopName);
    final Uri googleMapsUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude($encodedName)',
    );

    try {
      if (await canLaunchUrl(googleMapsUrl)) {
        return await launchUrl(
          googleMapsUrl,
          mode: LaunchMode.externalApplication,
        );
      } else {
        final Uri geoUri = Uri.parse(
          'geo:$latitude,$longitude?q=$latitude,$longitude($encodedName)',
        );
        return await launchUrl(geoUri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> makePhoneCall({required String phoneNumber}) async {
    final cleanPhone = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    final Uri phoneUri = Uri.parse('tel:$cleanPhone');

    try {
      if (await canLaunchUrl(phoneUri)) {
        return await launchUrl(phoneUri);
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
