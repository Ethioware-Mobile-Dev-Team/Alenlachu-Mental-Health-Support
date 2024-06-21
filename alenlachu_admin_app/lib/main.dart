import 'package:alenlachu_admin_app/core/app.dart';
import 'package:alenlachu_admin_app/data/services/helper/show_toast.dart';
import 'package:alenlachu_admin_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp());
  } catch (e) {
    showToast(message: e.toString());
  }
}
