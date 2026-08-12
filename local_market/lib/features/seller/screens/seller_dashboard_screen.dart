import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_typography.dart';
import '../../../widgets/buttons/outline_button.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/navigation/custom_app_bar.dart';
import '../../../widgets/status/verified_badge.dart';
import '../repositories/mock_seller_repository.dart';

class SellerDashboardScreen extends StatefulWidget {
  const SellerDashboardScreen({super.key});

  @override
  State<SellerDashboardScreen> createState() => _SellerDashboardScreenState();
}

class _SellerDashboardScreenState extends State<SellerDashboardScreen> {
  bool _isOpen = true;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: MockSellerRepository.instance,
      builder: (context, _) {
        final repo = MockSellerRepository.instance;
        final shop = repo.currentShop;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: CustomAppBar(
            title: 'Seller Control Center',
            actions: [
              TextButton.icon(
                icon: const Icon(Icons.shopping_bag_outlined, size: 18),
                label: const Text('Buyer Mode'),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.buyerHome);
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shop Profile Header Card
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: AppSpacing.borderRadiusLg,
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            decoration: const BoxDecoration(
                              color: AppColors.primaryLight,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.storefront,
                              color: AppColors.primary,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        shop?.shopName ??
                                            'Rahman Grocery Store',
                                        style: AppTypography.screenTitle,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (shop?.verified ?? true) ...[
                                      const SizedBox(width: AppSpacing.xs),
                                      const VerifiedBadge(),
                                    ],
                                  ],
                                ),
                                Text(
                                  'ID: ${shop?.id ?? "LM-SHOP-847291"} • ${shop?.category ?? "Grocery"}',
                                  style: AppTypography.caption,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: AppSpacing.lg),

                      // Shop Open / Closed Toggle Switch
                      Material(
                        color: Colors.transparent,
                        child: SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 12,
                                color: _isOpen
                                    ? AppColors.openStatus
                                    : AppColors.closedStatus,
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                _isOpen
                                    ? 'Shop Status: OPEN'
                                    : 'Shop Status: CLOSED',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _isOpen
                                      ? AppColors.openStatus
                                      : AppColors.closedStatus,
                                ),
                              ),
                            ],
                          ),
                          subtitle: const Text(
                            'Controls shop visibility to local buyers',
                          ),
                          value: _isOpen,
                          onChanged: (val) {
                            setState(() {
                              _isOpen = val;
                            });
                            repo.toggleShopOpenStatus(val);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Metrics Grid
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricCard(
                        'Total Products',
                        '${repo.products.length}',
                        Icons.inventory_2_outlined,
                        AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: _buildMetricCard(
                        'Pending Orders',
                        '${repo.orders.length}',
                        Icons.schedule,
                        AppColors.warning,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),

                // Quick Actions Section
                const Text(
                  'Shopkeeper Actions',
                  style: AppTypography.sectionTitle,
                ),
                const SizedBox(height: AppSpacing.sm),

                PrimaryButton(
                  text: '📷 Add New Product',
                  icon: Icons.add_a_photo_outlined,
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.sellerAddProduct);
                  },
                ),
                const SizedBox(height: AppSpacing.md),

                Row(
                  children: [
                    Expanded(
                      child: AppOutlineButton(
                        text: 'Manage Products',
                        icon: Icons.inventory_2_outlined,
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.sellerManageProducts,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: AppOutlineButton(
                        text: 'View Orders (${repo.orders.length})',
                        icon: Icons.receipt_long_outlined,
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.sellerOrders);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),

                AppOutlineButton(
                  text: 'Edit Shop Profile',
                  icon: Icons.edit_note_outlined,
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.sellerOnboarding);
                  },
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMetricCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: AppSpacing.iconLg),
          const SizedBox(height: AppSpacing.sm),
          Text(value, style: AppTypography.display.copyWith(fontSize: 24)),
          Text(label, style: AppTypography.caption),
        ],
      ),
    );
  }
}
