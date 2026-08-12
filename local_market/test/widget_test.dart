import 'package:flutter_test/flutter_test.dart';
import 'package:local_market/main.dart';

void main() {
  testWidgets('Local Market initial splash load smoke test', (
    WidgetTester tester,
  ) async {
    // Build LocalMarketApp and trigger a frame.
    await tester.pumpWidget(const LocalMarketApp());

    // Verify that the Local Market title and tagline appear on Splash Screen.
    expect(find.text('Local Market'), findsOneWidget);
    expect(find.text('Your Local Shops. Your Choice.'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });
}
