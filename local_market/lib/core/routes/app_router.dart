import 'package:flutter/material.dart';
import 'app_routes.dart';
import '../../features/splash/screens/splash_screen.dart';
import '../../features/onboarding/screens/location_onboarding_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/home/screens/buyer_home_screen.dart';
import '../../features/search/screens/search_screen.dart';
import '../../features/shops/screens/shop_details_screen.dart';
import '../../features/products/screens/product_details_screen.dart';
import '../../features/cart/screens/cart_screen.dart';
import '../../features/checkout/screens/checkout_screen.dart';
import '../../features/orders/screens/order_tracking_screen.dart';
import '../../features/seller/screens/seller_dashboard_screen.dart';
import '../../features/profile/screens/profile_screen.dart';

/// Central Route Generator for Local Market.
abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.onboardingLocation:
        return MaterialPageRoute(
          builder: (_) => const LocationOnboardingScreen(),
        );
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.buyerHome:
        return MaterialPageRoute(builder: (_) => const BuyerHomeScreen());
      case AppRoutes.search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case AppRoutes.shopDetails:
        return MaterialPageRoute(builder: (_) => const ShopDetailsScreen());
      case AppRoutes.productDetails:
        return MaterialPageRoute(builder: (_) => const ProductDetailsScreen());
      case AppRoutes.cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case AppRoutes.checkout:
        return MaterialPageRoute(builder: (_) => const CheckoutScreen());
      case AppRoutes.orderTracking:
        return MaterialPageRoute(builder: (_) => const OrderTrackingScreen());
      case AppRoutes.sellerDashboard:
        return MaterialPageRoute(builder: (_) => const SellerDashboardScreen());
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
