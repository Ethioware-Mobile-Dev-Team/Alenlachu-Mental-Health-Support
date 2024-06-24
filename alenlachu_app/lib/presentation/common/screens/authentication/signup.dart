import 'package:alenlachu_app/blocs/common/authentication/authentication_bloc.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_event.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_state.dart';
import 'package:alenlachu_app/presentation/common/screens/authentication/login.dart';
import 'package:alenlachu_app/presentation/common/screens/authentication/signup.dart';
import 'package:alenlachu_app/presentation/common/widgets/form_container.dart';
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
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginPage()));
          } else if (state is Authenticated) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const UserLandingPage()));
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FormContainer(
                controller: _nameController,
                labelText: 'Full Name',
                isPasswordField: false,
                inputType: TextInputType.text,
              ),
              const SizedBox(
                height: 10,
              ),
              FormContainer(
                controller: _emailController,
                labelText: 'Email',
                isPasswordField: false,
                inputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 10,
              ),
              FormContainer(
                controller: _passwordController,
                labelText: 'Password',
                isPasswordField: true,
                inputType: TextInputType.text,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text("Don't Have an account?"),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                    },
                    child: const Text("Login"),
                  )
                ],
              ),
              MaterialButton(onPressed: () {
                context.read<AuthenticationBloc>().add(SignUpRequested(
                    name: _nameController.text.trim(),
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim()));
              }, child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is Authenticating) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(child: Text("Sign Up"));
                  }
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
