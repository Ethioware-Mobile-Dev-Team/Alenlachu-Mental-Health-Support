import 'package:alenlachu_app/blocs/common/authentication/authentication_state.dart';
import 'package:alenlachu_app/presentation/common/screens/authentication/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_bloc.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_event.dart';

class PhoneNumberInputPage extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();

  PhoneNumberInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Phone Number'),
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is Authenticating) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Authenticating...'),
              ),
            );
          } else if (state is VerifyPhoneAuthenticationCode) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  OTPVerificationPage(verificationId: state.verficationId),
            ));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(
                    VerifyPhoneNumber(phoneNumber: _phoneController.text),
                  );
                },
                child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    if (state is Authenticating) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return const Text('Verify Phone Number');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
