import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/impl/real_location_service.dart';
import '../../../core/services/location_service.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/product_model.dart';
import '../../../models/shop_model.dart';
import '../../../widgets/cards/category_card.dart';
import '../../../widgets/cards/product_card_foundation.dart';
import '../../../widgets/cards/shop_card_foundation.dart';
import '../../../widgets/inputs/custom_text_field.dart';
import '../../../widgets/inputs/search_field.dart';
import '../../../widgets/location_row.dart';
import '../../../widgets/navigation/buyer_bottom_nav_bar.dart';
import '../../../widgets/navigation/custom_app_bar.dart';
import '../../../widgets/states/empty_state_widget.dart';
import '../../../widgets/states/error_state_widget.dart';
import '../../../widgets/states/loading_widget.dart';
import '../../cart/screens/cart_screen.dart';
import '../../orders/screens/order_tracking_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../../search/screens/search_screen.dart';
import '../repositories/home_repository.dart';
import '../repositories/mock_home_repository.dart';

class BuyerHomeScreen extends StatefulWidget {
  final HomeRepository? repository;
  final LocationService? locationService;

  const BuyerHomeScreen({super.key, this.repository, this.locationService});

  @override
  State<BuyerHomeScreen> createState() => _BuyerHomeScreenState();
}

class _BuyerHomeScreenState extends State<BuyerHomeScreen> {
  late HomeRepository _repository;
  late LocationService _locationService;

  int _currentTab = 0;
  bool _isLoading = true;
  String? _errorMessage;

  String _currentLocationName = 'Beldanga';
  List<CategoryItem> _categories = [];
  List<ShopModel> _shops = [];
  List<ProductModel> _products = [];

  final TextEditingController _manualLocationController =
      TextEditingController();

  final List<String> _popularLocalAreas = const [
    'Beldanga',
    'Berhampore',
    'Kandi',
    'Jangipur',
    'Murshidabad',
    'Kolkata',
  ];

  @override
  void initState() {
    super.initState();
    _repository = widget.repository ?? MockHomeRepository();
    _locationService = widget.locationService ?? RealLocationService();
    _loadHomeData();
  }

  @override
  void dispose() {
    _manualLocationController.dispose();
    super.dispose();
  }

  Future<void> _loadHomeData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      if (_locationService is RealLocationService) {
        _currentLocationName =
            (_locationService as RealLocationService).currentLocationName;
      }

      final categories = await _repository.getCategories();
      final shops = await _repository.getNearbyShops(
        locationName: _currentLocationName,
      );
      final products = await _repository.getNearbyProducts(
        locationName: _currentLocationName,
      );

      if (!mounted) return;

      setState(() {
        _categories = categories;
        _shops = shops;
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Failed to load local market data. Please try again.';
        _isLoading = false;
      });
    }
  }

  void _showLocationChangeModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusLg),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: AppSpacing.lg,
            bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Change Location',
                    style: AppTypography.sectionTitle,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              CustomTextField(
                label: 'Enter Town or Area Name',
                hint: 'e.g. Beldanga, Station Road',
                controller: _manualLocationController,
                prefixIcon: const Icon(Icons.location_city),
              ),
              const SizedBox(height: AppSpacing.md),
              const Text('Popular Local Markets', style: AppTypography.label),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.xs,
                children: _popularLocalAreas.map((area) {
                  return ChoiceChip(
                    label: Text(area),
                    selected: _currentLocationName == area,
                    onSelected: (selected) {
                      if (selected) {
                        _manualLocationController.text = area;
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: () {
                  final text = _manualLocationController.text.trim();
                  final newArea = text.isNotEmpty ? text : 'Beldanga';
                  if (_locationService is RealLocationService) {
                    (_locationService as RealLocationService).setManualLocation(
                      newArea,
                    );
                  }
                  setState(() {
                    _currentLocationName = newArea;
                  });
                  Navigator.pop(context);
                  _loadHomeData();
                },
                child: const Text('Update Location'),
              ),
            ],
          ),
        );
      },
    );
  }

  IconData _getCategoryIcon(String iconName) {
    switch (iconName) {
      case 'eco':
        return Icons.eco_outlined;
      case 'apple':
        return Icons.apple_outlined;
      case 'egg':
        return Icons.egg_outlined;
      case 'bakery_dining':
        return Icons.bakery_dining_outlined;
      case 'set_meal':
        return Icons.set_meal_outlined;
      case 'clean_hands':
        return Icons.clean_hands_outlined;
      case 'shopping_bag':
      default:
        return Icons.shopping_bag_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _currentTab == 0
          ? CustomAppBar(
              titleWidget: LocationRow(
                locationName: _currentLocationName,
                onTap: _showLocationChangeModal,
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_none_rounded),
                  onPressed: () {},
                ),
              ],
            )
          : null,
      body: SafeArea(
        child: IndexedStack(
          index: _currentTab,
          children: [
            _buildHomeTabContent(),
            const SearchScreen(),
            const CartScreen(),
            const OrderTrackingScreen(),
            const ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BuyerBottomNavBar(
        currentIndex: _currentTab,
        onTap: (index) {
          setState(() {
            _currentTab = index;
          });
        },
      ),
    );
  }

  Widget _buildHomeTabContent() {
    if (_isLoading) {
      return const LoadingWidget(
        message: 'Loading nearby shops and products...',
      );
    }

    if (_errorMessage != null) {
      return ErrorStateWidget(
        title: 'Connection Error',
        errorMessage: _errorMessage!,
        onRetry: _loadHomeData,
      );
    }

    if (_shops.isEmpty && _products.isEmpty) {
      return EmptyStateWidget(
        title: 'No Local Shops Nearby',
        subtitle:
            'No shops found in $_currentLocationName yet. Try switching to a nearby market area.',
        actionText: 'Change Location',
        onAction: _showLocationChangeModal,
      );
    }

    return RefreshIndicator(
      onRefresh: _loadHomeData,
      color: AppColors.primary,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Input
            SearchField(
              hintText: 'Search products or shops in $_currentLocationName...',
              onChanged: (query) {},
            ),
            const SizedBox(height: AppSpacing.lg),

            // Categories Section
            const Text('Categories', style: AppTypography.sectionTitle),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  return CategoryCard(
                    title: cat.title,
                    icon: _getCategoryIcon(cat.iconName),
                    onTap: () {},
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Nearby Shops Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Nearby Shops', style: AppTypography.sectionTitle),
                TextButton(onPressed: () {}, child: const Text('See All')),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _shops.length,
              itemBuilder: (context, index) {
                final shop = _shops[index];
                return ShopCardFoundation(
                  shopName: shop.shopName,
                  category: shop.category,
                  distanceText: '0.${(index + 3)} km away',
                  isOpen: true,
                  isVerified: shop.verified,
                  deliveryAvailable: shop.deliveryEnabled,
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.shopDetails);
                  },
                );
              },
            ),
            const SizedBox(height: AppSpacing.lg),

            // Nearby Products Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Nearby Products',
                  style: AppTypography.sectionTitle,
                ),
                TextButton(onPressed: () {}, child: const Text('See All')),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: AppSpacing.sm,
                mainAxisSpacing: AppSpacing.sm,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final prod = _products[index];
                final shopName = index < _shops.length
                    ? _shops[index].shopName
                    : 'Local Store';
                return ProductCardFoundation(
                  productName: prod.name,
                  price: prod.price,
                  unit: prod.unit,
                  shopName: shopName,
                  distanceText: '0.${(index + 4)} km',
                  isAvailable: prod.available,
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.productDetails);
                  },
                );
              },
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}
