import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_typography.dart';
import '../../../widgets/buttons/primary_button.dart';

/// Local Market Animated Splash Screen
class SplashScreen extends StatefulWidget {
  final bool autoNavigate;

  const SplashScreen({super.key, this.autoNavigate = true});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();

    if (widget.autoNavigate) {
      _navigationTimer = Timer(const Duration(milliseconds: 2200), () {
        if (mounted) {
          Navigator.pushReplacementNamed(context, AppRoutes.onboardingLocation);
        }
      });
    }
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onGetStartedPressed() {
    _navigationTimer?.cancel();
    Navigator.pushReplacementNamed(context, AppRoutes.onboardingLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.storefront_rounded,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        AppConstants.appName,
                        style: AppTypography.display.copyWith(
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        AppConstants.appTagline,
                        style: AppTypography.body.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              FadeTransition(
                opacity: _fadeAnimation,
                child: PrimaryButton(
                  text: 'Get Started',
                  backgroundColor: AppColors.secondary,
                  textColor: Colors.white,
                  icon: Icons.arrow_forward,
                  onPressed: _onGetStartedPressed,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }
}
