import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_market/features/onboarding/screens/location_onboarding_screen.dart';

void main() {
  Widget buildTestableWidget(Widget child) {
    return MaterialApp(home: child);
  }

  testWidgets('Location Onboarding shows explanation UI by default', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      buildTestableWidget(const LocationOnboardingScreen()),
    );

    expect(find.text('Find Shops Near You'), findsOneWidget);
    expect(find.text('Allow Location'), findsOneWidget);
    expect(find.text('Enter Location Manually'), findsOneWidget);
  });

  testWidgets(
    'Location Onboarding displays manual location modal on button tap',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(const LocationOnboardingScreen()),
      );

      await tester.tap(find.text('Enter Location Manually'));
      await tester.pumpAndSettle();

      expect(find.text('Select Location'), findsOneWidget);
      expect(find.text('Popular Nearby Areas'), findsOneWidget);
      expect(find.text('Beldanga'), findsOneWidget);
      expect(find.text('Confirm Location'), findsOneWidget);
    },
  );

  testWidgets('Location Onboarding handles permission denied view mode', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      buildTestableWidget(
        const LocationOnboardingScreen(
          initialMode: OnboardingViewMode.permissionDenied,
        ),
      ),
    );

    expect(find.text('Location Permission Denied'), findsOneWidget);
    expect(find.text('Try Again'), findsOneWidget);
  });
}
