import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/impl/real_location_service.dart';
import '../../../core/services/location_service.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/shop_model.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/inputs/custom_text_field.dart';
import '../../../widgets/navigation/custom_app_bar.dart';
import '../repositories/mock_seller_repository.dart';

class SellerOnboardingScreen extends StatefulWidget {
  final LocationService? locationService;

  const SellerOnboardingScreen({super.key, this.locationService});

  @override
  State<SellerOnboardingScreen> createState() => _SellerOnboardingScreenState();
}

class _SellerOnboardingScreenState extends State<SellerOnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  late LocationService _locationService;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _openTimeController = TextEditingController(
    text: '07:00 AM',
  );
  final TextEditingController _closeTimeController = TextEditingController(
    text: '09:00 PM',
  );
  final TextEditingController _deliveryFeeController = TextEditingController(
    text: '10',
  );

  String _selectedCategory = 'Grocery & Staples';
  bool _deliveryEnabled = true;
  bool _isLoadingLocation = false;
  double _latitude = 23.9318;
  double _longitude = 88.2514;
  String _locationStatusText = 'Location: Default (Beldanga Market)';

  final List<String> _categories = const [
    'Grocery & Staples',
    'Fresh Vegetables',
    'Fruits',
    'Dairy & Eggs',
    'Bakery & Snacks',
    'Fish & Meat',
    'Personal Care',
  ];

  @override
  void initState() {
    super.initState();
    _locationService = widget.locationService ?? RealLocationService();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _descController.dispose();
    _openTimeController.dispose();
    _closeTimeController.dispose();
    _deliveryFeeController.dispose();
    super.dispose();
  }

  Future<void> _fetchDeviceLocation() async {
    setState(() => _isLoadingLocation = true);
    final success = await _locationService.requestLocationPermission();
    if (!mounted) return;

    if (success) {
      final coords = await _locationService.getCurrentCoordinates();
      if (coords != null) {
        setState(() {
          _latitude = coords['latitude']!;
          _longitude = coords['longitude']!;
          _locationStatusText =
              'GPS Coordinates: ${_latitude.toStringAsFixed(3)}, ${_longitude.toStringAsFixed(3)}';
          _isLoadingLocation = false;
        });
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Shop GPS Location Updated!')),
        );
        return;
      }
    }

    setState(() {
      _isLoadingLocation = false;
      _locationStatusText = 'Location: Manual Address Entry';
    });
  }

  void _onRegisterShopPressed() async {
    if (!_formKey.currentState!.validate()) return;

    final shopName = _nameController.text.trim();
    final uniqueShopId =
        'LM-SHOP-${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}';

    final newShop = ShopModel(
      id: uniqueShopId,
      ownerId: 'seller_user_1',
      shopName: shopName,
      category: _selectedCategory,
      address: _addressController.text.trim(),
      latitude: _latitude,
      longitude: _longitude,
      phone: _phoneController.text.trim(),
      openingTime: _openTimeController.text.trim(),
      closingTime: _closeTimeController.text.trim(),
      deliveryEnabled: _deliveryEnabled,
      deliveryFee: double.tryParse(_deliveryFeeController.text.trim()) ?? 10.0,
      verified: true,
      createdAt: DateTime.now(),
    );

    await MockSellerRepository.instance.saveShopProfile(newShop);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Shop "$shopName" Registered! ID: $uniqueShopId'),
        backgroundColor: AppColors.primary,
      ),
    );

    Navigator.pushReplacementNamed(context, AppRoutes.sellerDashboard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'Physical Shop Registration'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: AppSpacing.borderRadiusLg,
                ),
                child: const Row(
                  children: [
                    Icon(Icons.storefront, color: AppColors.primary, size: 36),
                    SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Register Local Shop',
                            style: AppTypography.sectionTitle,
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Must represent a real physical store in your local market area.',
                            style: AppTypography.caption,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              CustomTextField(
                label: 'Shop Display Name *',
                hint: 'e.g. Rahman Grocery Store',
                controller: _nameController,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Shop name is required' : null,
              ),
              const SizedBox(height: AppSpacing.md),

              const Text('Shop Category *', style: AppTypography.label),
              const SizedBox(height: AppSpacing.xs),
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
                items: _categories
                    .map(
                      (cat) => DropdownMenuItem(value: cat, child: Text(cat)),
                    )
                    .toList(),
                onChanged: (val) => setState(() => _selectedCategory = val!),
              ),
              const SizedBox(height: AppSpacing.md),

              CustomTextField(
                label: 'Shopkeeper Phone Number *',
                hint: 'e.g. +91 9876543210',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                validator: (val) => val == null || val.isEmpty
                    ? 'Phone number is required'
                    : null,
              ),
              const SizedBox(height: AppSpacing.md),

              CustomTextField(
                label: 'Physical Market Address & Area *',
                hint: 'e.g. Station Road, Beldanga Market',
                controller: _addressController,
                maxLines: 2,
                validator: (val) => val == null || val.isEmpty
                    ? 'Physical address is required'
                    : null,
              ),
              const SizedBox(height: AppSpacing.md),

              // Location Picker Card
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppSpacing.borderRadiusMd,
                  border: Border.all(color: AppColors.divider),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Physical Shop GPS Location',
                      style: AppTypography.label,
                    ),
                    const SizedBox(height: 4),
                    Text(_locationStatusText, style: AppTypography.caption),
                    const SizedBox(height: AppSpacing.sm),
                    OutlinedButton.icon(
                      onPressed: _isLoadingLocation
                          ? null
                          : _fetchDeviceLocation,
                      icon: _isLoadingLocation
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.my_location, size: 18),
                      label: Text(
                        _isLoadingLocation
                            ? 'Detecting GPS...'
                            : 'Use Current Device GPS',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: 'Opening Time',
                      controller: _openTimeController,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: CustomTextField(
                      label: 'Closing Time',
                      controller: _closeTimeController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              Material(
                color: Colors.transparent,
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'Enable Home Delivery',
                    style: AppTypography.label,
                  ),
                  subtitle: const Text(
                    'Offer delivery to buyers within local distance',
                  ),
                  value: _deliveryEnabled,
                  onChanged: (val) => setState(() => _deliveryEnabled = val),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              PrimaryButton(
                text: 'Register Physical Shop',
                icon: Icons.check_circle_outline,
                onPressed: _onRegisterShopPressed,
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
