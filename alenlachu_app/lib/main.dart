import 'package:alenlachu_app/blocs/common/authentication/authentication_bloc.dart';
import 'package:alenlachu_app/core/common/app.dart';
import 'package:alenlachu_app/core/common/login_manager.dart';
import 'package:alenlachu_app/data/common/models/user_model.dart';
import 'package:alenlachu_app/data/common/services/authentication/authentication_service.dart';
import 'package:alenlachu_app/presentation/common/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final AuthServices authServices = AuthServices();
    UserModel? user = await LoginManager.getUser();

    runApp(BlocProvider(
      create: (context) => AuthenticationBloc(authServices),
      child: MainApp(user: user),
    ));
  } catch (e) {
    showToast(e.toString());
  }
}
