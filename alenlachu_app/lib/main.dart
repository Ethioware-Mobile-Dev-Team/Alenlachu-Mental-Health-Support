import 'package:alenlachu_app/core/admin/app.dart';
import 'package:alenlachu_app/core/common/login_manager.dart';
import 'package:alenlachu_app/core/user/app.dart';
import 'package:alenlachu_app/data/common/models/user_model.dart';
import 'package:alenlachu_app/presentation/common/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    UserModel? user = await LoginManager.getUser();
    if (user != null) {
      if (user.role == 'admin') {
        runApp(const AdminApp());
      } else {
        runApp(const UserApp());
      }
    }
  } catch (e) {
    showToast(e.toString());
  }
}
