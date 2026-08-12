import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_market/features/products/screens/product_details_screen.dart';
import 'package:local_market/features/shops/screens/shop_details_screen.dart';

void main() {
  Widget buildTestableWidget(Widget child) {
    return MaterialApp(home: child);
  }

  testWidgets(
    'ShopDetailsScreen displays shop header, address, hours and actions',
    (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(const ShopDetailsScreen()));
      await tester.pumpAndSettle();

      expect(find.text('ABC Grocery Store'), findsWidgets);
      expect(find.text('Get Directions'), findsOneWidget);
      expect(find.text('Call Shop'), findsOneWidget);
      expect(find.text('Shop Products'), findsOneWidget);
    },
  );

  testWidgets(
    'ProductDetailsScreen displays product details, shop banner, quantity & Add to Cart',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(const ProductDetailsScreen()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Fresh Desi Tomatoes'), findsWidgets);
      expect(find.text('ABC Grocery Store'), findsOneWidget);
      expect(find.text('Visit Shop\n(In-Store Buy)'), findsOneWidget);
      expect(find.text('Home Delivery\n(Fee ₹10)'), findsOneWidget);
      expect(find.text('Add to Cart'), findsOneWidget);
    },
  );

  testWidgets(
    'ProductDetailsScreen quantity selector increments and decrements',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(const ProductDetailsScreen()),
      );
      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);

      // Tap '+' to increment
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      expect(find.text('2'), findsOneWidget);

      // Tap '-' to decrement
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pumpAndSettle();
      expect(find.text('1'), findsOneWidget);
    },
  );
}
