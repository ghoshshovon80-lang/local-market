import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../widgets/navigation/custom_app_bar.dart';
import '../../../widgets/states/empty_state_widget.dart';
import '../../../widgets/status/availability_badge.dart';
import '../repositories/mock_seller_repository.dart';

class ManageProductsScreen extends StatelessWidget {
  const ManageProductsScreen({super.key});

  void _confirmDeleteProduct(
    BuildContext context,
    String productId,
    String productName,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Delete Product?',
            style: AppTypography.sectionTitle,
          ),
          content: Text(
            'Are you sure you want to delete "$productName"? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
              onPressed: () {
                Navigator.pop(context);
                MockSellerRepository.instance.deleteProduct(productId);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Deleted "$productName"')),
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: MockSellerRepository.instance,
      builder: (context, _) {
        final repo = MockSellerRepository.instance;
        final products = repo.products;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: CustomAppBar(
            title: 'Manage Products (${products.length})',
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.sellerAddProduct);
                },
              ),
            ],
          ),
          body: products.isEmpty
              ? EmptyStateWidget(
                  title: 'No Products Listed',
                  subtitle:
                      'Add your physical shop products so local buyers can discover them.',
                  icon: Icons.inventory_2_outlined,
                  actionText: '📷 Add Product',
                  onAction: () {
                    Navigator.pushNamed(context, AppRoutes.sellerAddProduct);
                  },
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: AppSpacing.sm + 4),
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryLight,
                                    borderRadius: AppSpacing.borderRadiusSm,
                                  ),
                                  child: const Icon(
                                    Icons.shopping_bag_outlined,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        style: AppTypography.cardTitle,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        CurrencyFormatter.formatWithUnit(
                                          product.price,
                                          product.unit,
                                        ),
                                        style: AppTypography.priceMedium,
                                      ),
                                      const SizedBox(height: 4),
                                      AvailabilityBadge(
                                        isAvailable: product.available,
                                      ),
                                    ],
                                  ),
                                ),
                                Switch(
                                  value: product.available,
                                  onChanged: (val) {
                                    repo.toggleProductAvailability(
                                      product.id,
                                      val,
                                    );
                                  },
                                ),
                              ],
                            ),
                            const Divider(height: AppSpacing.md),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton.icon(
                                  icon: const Icon(
                                    Icons.edit_outlined,
                                    size: 18,
                                  ),
                                  label: const Text('Edit'),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.sellerAddProduct,
                                      arguments: product,
                                    );
                                  },
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                TextButton.icon(
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors.error,
                                  ),
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    size: 18,
                                  ),
                                  label: const Text('Delete'),
                                  onPressed: () => _confirmDeleteProduct(
                                    context,
                                    product.id,
                                    product.name,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
