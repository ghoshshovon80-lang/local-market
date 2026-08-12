import 'package:flutter/material.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/cart/screens/cart_screen.dart';
import '../../features/checkout/screens/checkout_screen.dart';
import '../../features/home/screens/buyer_home_screen.dart';
import '../../features/onboarding/screens/location_onboarding_screen.dart';
import '../../features/orders/screens/order_tracking_screen.dart';
import '../../features/products/screens/product_details_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/search/screens/search_screen.dart';
import '../../features/seller/screens/add_edit_product_screen.dart';
import '../../features/seller/screens/manage_products_screen.dart';
import '../../features/seller/screens/seller_dashboard_screen.dart';
import '../../features/seller/screens/seller_onboarding_screen.dart';
import '../../features/seller/screens/seller_orders_screen.dart';
import '../../features/shops/screens/shop_details_screen.dart';
import '../../features/splash/screens/splash_screen.dart';
import '../../models/product_model.dart';
import 'app_routes.dart';

/// Central Route Generator for Local Market application navigation.
abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );

      case AppRoutes.onboardingLocation:
        return MaterialPageRoute(
          builder: (_) => const LocationOnboardingScreen(),
          settings: settings,
        );

      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );

      case AppRoutes.buyerHome:
        return MaterialPageRoute(
          builder: (_) => const BuyerHomeScreen(),
          settings: settings,
        );

      case AppRoutes.search:
        return MaterialPageRoute(
          builder: (_) => const SearchScreen(),
          settings: settings,
        );

      case AppRoutes.shopDetails:
        final shopId = settings.arguments as String? ?? 'shop_1';
        return MaterialPageRoute(
          builder: (_) => ShopDetailsScreen(shopId: shopId),
          settings: settings,
        );

      case AppRoutes.productDetails:
        final productId = settings.arguments as String? ?? 'prod_1';
        return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(productId: productId),
          settings: settings,
        );

      case AppRoutes.cart:
        return MaterialPageRoute(
          builder: (_) => const CartScreen(),
          settings: settings,
        );

      case AppRoutes.checkout:
        return MaterialPageRoute(
          builder: (_) => const CheckoutScreen(),
          settings: settings,
        );

      case AppRoutes.orderTracking:
        return MaterialPageRoute(
          builder: (_) => const OrderTrackingScreen(),
          settings: settings,
        );

      case AppRoutes.sellerDashboard:
        return MaterialPageRoute(
          builder: (_) => const SellerDashboardScreen(),
          settings: settings,
        );

      case AppRoutes.sellerOnboarding:
        return MaterialPageRoute(
          builder: (_) => const SellerOnboardingScreen(),
          settings: settings,
        );

      case AppRoutes.sellerAddProduct:
        final prodToEdit = settings.arguments as ProductModel?;
        return MaterialPageRoute(
          builder: (_) => AddEditProductScreen(productToEdit: prodToEdit),
          settings: settings,
        );

      case AppRoutes.sellerManageProducts:
        return MaterialPageRoute(
          builder: (_) => const ManageProductsScreen(),
          settings: settings,
        );

      case AppRoutes.sellerOrders:
        return MaterialPageRoute(
          builder: (_) => const SellerOrdersScreen(),
          settings: settings,
        );

      case AppRoutes.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
          settings: settings,
        );
    }
  }
}
