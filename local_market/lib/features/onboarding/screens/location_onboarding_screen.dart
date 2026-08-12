import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/secondary_button.dart';

class LocationOnboardingScreen extends StatelessWidget {
  const LocationOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location Setup')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on, size: 72, color: Colors.green),
            const SizedBox(height: 24),
            const Text(
              'Find Shops Near You',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Local Market uses your location to show nearby physical shops and real products.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 36),
            PrimaryButton(
              text: 'Allow Location',
              icon: Icons.my_location,
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.buyerHome);
              },
            ),
            const SizedBox(height: 12),
            SecondaryButton(
              text: 'Enter Location Manually',
              icon: Icons.edit_location_alt,
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.buyerHome);
              },
            ),
          ],
        ),
      ),
    );
  }
}
