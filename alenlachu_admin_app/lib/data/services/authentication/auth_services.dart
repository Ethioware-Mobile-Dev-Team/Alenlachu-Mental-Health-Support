import 'package:alenlachu_admin_app/data/models/admin_model.dart';
import 'package:alenlachu_admin_app/data/services/helper/show_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthServices {
  final _auth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<auth.User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<void> createUserWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      auth.UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      AdminModel newAdmin =
          AdminModel(id: userCredential.user!.uid, name: name, email: email);
      await _db
          .collection('admins')
          .doc(userCredential.user!.uid)
          .set(newAdmin.toJson());
    } catch (e) {
      showToast(message: e.toString());
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      showToast(message: e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      showToast(message: e.toString());
    }
  }
}
