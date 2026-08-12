import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_market/features/home/repositories/home_repository.dart';
import 'package:local_market/features/home/screens/buyer_home_screen.dart';
import 'package:local_market/models/product_model.dart';
import 'package:local_market/models/shop_model.dart';

class EmptyMockHomeRepository implements HomeRepository {
  @override
  Future<List<CategoryItem>> getCategories() async => [];

  @override
  Future<List<ShopModel>> getNearbyShops({
    required String locationName,
  }) async => [];

  @override
  Future<List<ProductModel>> getNearbyProducts({
    required String locationName,
  }) async => [];
}

void main() {
  Widget buildTestableWidget(Widget child) {
    return MaterialApp(home: child);
  }

  testWidgets(
    'Buyer Home screen displays location header, categories, shops and products',
    (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(const BuyerHomeScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Beldanga'), findsOneWidget);
      expect(find.text('Categories'), findsOneWidget);
      expect(find.text('Nearby Shops'), findsOneWidget);
      expect(find.text('Nearby Products'), findsOneWidget);
      expect(find.text('ABC Grocery Store'), findsWidgets);
      expect(find.text('Fresh Desi Tomatoes'), findsOneWidget);
    },
  );

  testWidgets('Buyer Home bottom navigation switches tabs cleanly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget(const BuyerHomeScreen()));
    await tester.pumpAndSettle();

    // Tap 'Search' tab
    await tester.tap(find.text('Search').last);
    await tester.pumpAndSettle();
    expect(find.text('Search Results Placeholder'), findsOneWidget);

    // Tap 'Cart' tab
    await tester.tap(find.text('Cart').last);
    await tester.pumpAndSettle();
    expect(find.text('Cart Placeholder'), findsOneWidget);
  });

  testWidgets('Buyer Home displays empty state when no shops/products exist', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      buildTestableWidget(
        BuyerHomeScreen(repository: EmptyMockHomeRepository()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No Local Shops Nearby'), findsOneWidget);
    expect(find.text('Change Location'), findsOneWidget);
  });
}
