import 'package:flutter/material.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/primary_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Local Market',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Enter your phone number to sign in or create account.'),
            const SizedBox(height: 24),
            const CustomTextField(
              label: 'Mobile Number',
              hint: 'Enter 10-digit number',
              keyboardType: TextInputType.phone,
              prefixIcon: Icon(Icons.phone),
            ),
            const SizedBox(height: 24),
            PrimaryButton(text: 'Send OTP', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
