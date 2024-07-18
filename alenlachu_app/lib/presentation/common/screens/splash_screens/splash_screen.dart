import 'dart:async';

import 'package:alenlachu_app/blocs/common/authentication/authentication_bloc.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_state.dart';
import 'package:alenlachu_app/presentation/common/screens/authentication/login.dart';
import 'package:alenlachu_app/presentation/common/widgets/main_button.dart';
import 'package:alenlachu_app/presentation/common/widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 255, 255, 255)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            // Wave Pattern
            Positioned.fill(
              child: CustomPaint(
                painter: WavePainter(),
              ),
            ),
            // Floating Shapes
            Positioned(
              top: 100,
              left: 50,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.blue.withOpacity(0.5),
              ),
            ),
            const Positioned(
              bottom: 150,
              right: 50,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
              ),
            ),
            // Example Logo
            const Positioned(
              top: 160,
              left: 80,
              child: Text(
                'Alenlachu',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const Positioned(
              bottom: 150,
              left: 80,
              child: Text(
                'Support. Growth. Peace',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontStyle: FontStyle.italic),
              ),
            ),
            Positioned(
              bottom: 50,
              left: 80,
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  return MainButton(
                    child: state is Authenticated
                        ? const CircularProgressIndicator()
                        : const StyledText(lable: 'Get Started!'),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  );
                },
              ),
            ),
            // Example Welcome Text
            Center(
              child: LottieBuilder.asset(
                'assets/animations/anime1.json',
                // width: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blue.withOpacity(0.5);
    final path = Path()
      ..moveTo(0, size.height * 0.8)
      ..quadraticBezierTo(
        size.width / 4,
        size.height,
        size.width / 2,
        size.height * 0.8,
      )
      ..quadraticBezierTo(
        3 * size.width / 4,
        size.height * 0.6,
        size.width,
        size.height * 0.8,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
