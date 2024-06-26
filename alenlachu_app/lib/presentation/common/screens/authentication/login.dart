import 'package:alenlachu_app/blocs/common/authentication/authentication_bloc.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_event.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_state.dart';
import 'package:alenlachu_app/presentation/admin/screens/pages/landing/landing_page.dart';
import 'package:alenlachu_app/presentation/common/screens/authentication/signup.dart';
import 'package:alenlachu_app/presentation/common/widgets/form_container.dart';
import 'package:alenlachu_app/presentation/common/widgets/show_toast.dart';
import 'package:alenlachu_app/presentation/user/screens/pages/landing/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
          if (state is Authenticated) {
            showToast(state.user!.role);
            if (state.user!.role == 'admin') {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const AdminLandingPage()));
            } else {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const UserLandingPage()));
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                          builder: (context) => const SignUpPage()));
                    },
                    child: const Text("Sign Up"),
                  )
                ],
              ),
              MaterialButton(onPressed: () {
                context.read<AuthenticationBloc>().add(LoginRequested(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim()));
              }, child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is Authenticating) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(child: Text("Log in"));
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
