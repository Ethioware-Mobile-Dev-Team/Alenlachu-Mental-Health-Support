import 'package:alenlachu_app/blocs/common/authentication/authentication_bloc.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_event.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_state.dart';
import 'package:alenlachu_app/presentation/admin/screens/pages/landing/landing_page.dart';
import 'package:alenlachu_app/presentation/common/widgets/form_container.dart';
import 'package:alenlachu_app/presentation/common/widgets/main_button.dart';
import 'package:alenlachu_app/presentation/common/widgets/show_toast.dart';
import 'package:alenlachu_app/presentation/common/widgets/styled_text.dart';
import 'package:alenlachu_app/presentation/user/screens/pages/landing/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is Authenticated) {
            if (state.user!.role == 'admin') {
              Navigator.of(context).pushReplacementNamed('/adminLanding');
            } else {
              Navigator.of(context).pushReplacementNamed('/userLanding');
            }
          }
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: SignUpWavePainter(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 50),
                  FormContainer(
                    controller: _nameController,
                    labelText: 'Full Name',
                    isPasswordField: false,
                    inputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the Full Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  FormContainer(
                    controller: _emailController,
                    labelText: 'Email',
                    isPasswordField: false,
                    inputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  FormContainer(
                    controller: _passwordController,
                    labelText: 'Password',
                    isPasswordField: true,
                    inputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the Password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 100),
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      return MainButton(
                        onPressed: () {
                          context.read<AuthenticationBloc>().add(
                              SignUpRequested(
                                  name: _nameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim()));
                        },
                        child: state is Authenticating
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const StyledText(
                                lable: "Sign Up",
                              ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        // style: TextStyle(color: Colors.blueAccent),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blueAccent.withOpacity(0.3);
    final path = Path()
      ..moveTo(0, size.height * 0.4)
      ..quadraticBezierTo(
        size.width / 4,
        size.height * 0.3,
        size.width / 2,
        size.height * 0.4,
      )
      ..quadraticBezierTo(
        3 * size.width / 4,
        size.height * 0.5,
        size.width,
        size.height * 0.4,
      )
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
