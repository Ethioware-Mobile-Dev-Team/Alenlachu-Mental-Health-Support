import 'dart:convert';

import 'package:alenlachu_app/data/common/models/user_model.dart';
import 'package:alenlachu_app/presentation/common/widgets/show_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginManager {
  static const String _userKey = 'user';

  static Future<void> saveUser(UserModel user) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String userJson = jsonEncode(user.toJson());
      await prefs.setString(_userKey, userJson);
    } catch (e) {
      showToast(e.toString());
    }
  }

  static Future<UserModel?> getUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userJson = prefs.getString(_userKey);

      if (userJson != null) {
        UserModel user = UserModel.fromSnapshot(
            jsonDecode(userJson) as Map<String, dynamic>);
        return user;
      }
    } catch (e) {
      showToast(e.toString());
      return null;
    }

    return null;
  }

  static Future<void> removeUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userKey);
    } catch (e) {
      showToast(e.toString());
    }
  }
}
