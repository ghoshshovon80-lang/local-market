import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/impl/mock_location_service.dart';
import '../../../core/theme/app_typography.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/buttons/secondary_button.dart';
import '../../../widgets/inputs/custom_text_field.dart';
import '../../../widgets/states/error_state_widget.dart';
import '../../../widgets/states/loading_widget.dart';

enum OnboardingViewMode {
  explanation,
  loading,
  permissionDenied,
  locationUnavailable,
}

class LocationOnboardingScreen extends StatefulWidget {
  final AppLocationService? locationService;
  final OnboardingViewMode initialMode;

  const LocationOnboardingScreen({
    super.key,
    this.locationService,
    this.initialMode = OnboardingViewMode.explanation,
  });

  @override
  State<LocationOnboardingScreen> createState() =>
      _LocationOnboardingScreenState();
}

class _LocationOnboardingScreenState extends State<LocationOnboardingScreen> {
  late AppLocationService _locationService;
  late OnboardingViewMode _viewMode;
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
    _locationService = widget.locationService ?? AppLocationService();
    _viewMode = widget.initialMode;
  }

  @override
  void dispose() {
    _manualLocationController.dispose();
    super.dispose();
  }

  Future<void> _handleAllowLocation({
    bool simulateDenied = false,
    bool simulateError = false,
  }) async {
    setState(() {
      _viewMode = OnboardingViewMode.loading;
    });

    final success = await _locationService.requestLocationPermission(
      simulateDenied: simulateDenied,
      simulateError: simulateError,
    );

    if (!mounted) return;

    if (success) {
      _navigateToHome();
    } else {
      setState(() {
        if (_locationService.permissionState ==
            LocationPermissionState.unavailable) {
          _viewMode = OnboardingViewMode.locationUnavailable;
        } else {
          _viewMode = OnboardingViewMode.permissionDenied;
        }
      });
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacementNamed(context, AppRoutes.buyerHome);
  }

  void _showManualLocationModal() {
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
                    'Select Location',
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
                label: 'Enter Area / City',
                hint: 'e.g. Beldanga, Market Road',
                controller: _manualLocationController,
                prefixIcon: const Icon(Icons.search),
              ),
              const SizedBox(height: AppSpacing.md),
              const Text('Popular Nearby Areas', style: AppTypography.label),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.xs,
                children: _popularLocalAreas.map((area) {
                  return ChoiceChip(
                    label: Text(area),
                    selected: _manualLocationController.text == area,
                    onSelected: (selected) {
                      if (selected) {
                        _manualLocationController.text = area;
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSpacing.lg),
              PrimaryButton(
                text: 'Confirm Location',
                onPressed: () {
                  final text = _manualLocationController.text.trim();
                  final selectedArea = text.isNotEmpty ? text : 'Beldanga';
                  _locationService.setManualLocation(selectedArea);
                  Navigator.pop(context);
                  _navigateToHome();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Location Setup'), elevation: 0),
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_viewMode) {
      case OnboardingViewMode.loading:
        return const LoadingWidget(message: 'Detecting nearby shops...');

      case OnboardingViewMode.permissionDenied:
        return ErrorStateWidget(
          title: 'Location Permission Denied',
          errorMessage:
              'Location permission is disabled. You can still enter your location manually to find nearby shops.',
          onRetry: () => _handleAllowLocation(),
        );

      case OnboardingViewMode.locationUnavailable:
        return ErrorStateWidget(
          title: 'Location Services Unavailable',
          errorMessage:
              'Unable to retrieve GPS position. Please enter your local area manually to continue.',
          onRetry: _showManualLocationModal,
        );

      case OnboardingViewMode.explanation:
        return Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(AppSpacing.xl),
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.location_on_rounded,
                  size: 72,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              const Text(
                'Find Shops Near You',
                style: AppTypography.screenTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'Local Market uses your location to display real products from physical stores near your local area.',
                style: AppTypography.bodyMuted,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              PrimaryButton(
                text: 'Allow Location',
                icon: Icons.my_location,
                onPressed: () => _handleAllowLocation(),
              ),
              const SizedBox(height: AppSpacing.md),
              SecondaryButton(
                text: 'Enter Location Manually',
                icon: Icons.edit_location_alt,
                onPressed: _showManualLocationModal,
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
          ),
        );
    }
  }
}
