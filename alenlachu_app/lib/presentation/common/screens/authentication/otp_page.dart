import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_bloc.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_event.dart';

class OTPVerificationPage extends StatelessWidget {
  final String verificationId;
  final TextEditingController _otpController = TextEditingController();

  OTPVerificationPage({super.key, required this.verificationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _otpController,
              decoration: const InputDecoration(labelText: 'Verification Code'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(
                  SignInWithPhoneNumber(
                    verificationId: verificationId,
                    verificationCode: _otpController.text,
                  ),
                );
              },
              child: const Text('Verify & Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
