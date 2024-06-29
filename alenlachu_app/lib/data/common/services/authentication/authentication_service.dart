import 'package:alenlachu_app/core/common/login_manager.dart';
import 'package:alenlachu_app/data/common/models/user_model.dart';
import 'package:alenlachu_app/presentation/common/widgets/show_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthServices {
  final _auth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<auth.User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<UserModel?> createUserWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      auth.UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel newUser = UserModel(
          id: userCredential.user!.uid,
          name: name,
          email: email,
          password: password);
      await _db
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(newUser.toJson());
      await LoginManager.saveUser(newUser);
      return newUser;
    } catch (e) {
      showToast(e.toString());
      return null;
    }
  }

  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      auth.UserCredential? userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      auth.User? user = userCredential.user!;

      DocumentSnapshot<Map<String, dynamic>> doc =
          await _db.collection('users').doc(user.uid).get();
      if (doc.exists) {
        UserModel userModel = UserModel.fromSnapshot(doc.data()!);
        await LoginManager.saveUser(userModel);
        return userModel;
      }
    } catch (e) {
      showToast(e.toString());
      return null;
    }

    return null;
  }

  Future<UserModel?> getUserModel(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await _db.collection('users').doc(userId).get();
      if (doc.exists) {
        UserModel userModel = UserModel.fromSnapshot(doc.data()!);
        return userModel;
      }
    } catch (e) {
      showToast(e.toString());
      return null;
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await LoginManager.removeUser();
    } catch (e) {
      showToast(e.toString());
    }
  }
  Future<String?> getCurrentUserId() async {
    final user = _auth.currentUser;
    return user?.uid;
  }
}
