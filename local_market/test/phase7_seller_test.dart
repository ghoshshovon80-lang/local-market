import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_market/features/seller/repositories/mock_seller_repository.dart';
import 'package:local_market/features/seller/screens/add_edit_product_screen.dart';
import 'package:local_market/features/seller/screens/manage_products_screen.dart';
import 'package:local_market/features/seller/screens/seller_dashboard_screen.dart';
import 'package:local_market/features/seller/screens/seller_onboarding_screen.dart';
import 'package:local_market/features/seller/screens/seller_orders_screen.dart';

void main() {
  Widget buildTestableWidget(Widget child) {
    return MaterialApp(home: child);
  }

  testWidgets(
    'SellerOnboardingScreen renders registration form and location picker',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(const SellerOnboardingScreen()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Register Local Shop'), findsOneWidget);
      expect(find.text('Use Current Device GPS'), findsOneWidget);
      expect(find.text('Register Physical Shop'), findsOneWidget);
    },
  );

  testWidgets(
    'SellerDashboardScreen renders shop header, metrics and quick actions',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(const SellerDashboardScreen()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Rahman Grocery Store'), findsOneWidget);
      expect(find.text('Shop Status: OPEN'), findsOneWidget);
      expect(find.text('📷 Add New Product'), findsOneWidget);
      expect(find.text('Manage Products'), findsOneWidget);
    },
  );

  testWidgets(
    'AddEditProductScreen renders photo picker buttons and product fields',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(const AddEditProductScreen()),
      );
      await tester.pumpAndSettle();

      expect(find.text('📷 Take Photo'), findsOneWidget);
      expect(find.text('🖼️ Gallery'), findsOneWidget);
      expect(find.text('Save Product'), findsOneWidget);
    },
  );

  testWidgets('ManageProductsScreen renders product list and stock toggle', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget(const ManageProductsScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Fresh Desi Tomatoes'), findsOneWidget);
    expect(find.byType(Switch), findsWidgets);
  });

  testWidgets(
    'SellerOrdersScreen renders incoming orders and status pipeline button',
    (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(const SellerOrdersScreen()));
      await tester.pumpAndSettle();

      expect(find.text('LM-ORD-77821'), findsOneWidget);
      expect(find.text('Accept Order'), findsOneWidget);

      // Tap Accept Order
      await tester.tap(find.text('Accept Order'));
      await tester.pumpAndSettle();

      expect(
        MockSellerRepository.instance.orders.first.status.name,
        'accepted',
      );
    },
  );
}
