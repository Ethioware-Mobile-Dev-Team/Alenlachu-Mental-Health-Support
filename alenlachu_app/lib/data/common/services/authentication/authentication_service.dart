import 'dart:developer';

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

  Future<void> updateProfile(UserModel user) async {
    try {
      await _db.collection('users').doc(user.id).set(user.toJson());
    } catch (e) {
      showToast(e.toString());
    }
  }

  Future<UserModel?> getUserModel() async {
    try {
      final user = await getCurrentUser();
      DocumentSnapshot<Map<String, dynamic>> doc =
          await _db.collection('users').doc(user!.uid).get();
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

  Future<int> getTotalUserCount() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _db.collection('users').where('role', isEqualTo: 'user').get();
      return snapshot.size;
    } catch (e) {
      showToast(e.toString());
      return 0;
    }
  }

  Future<void> verifyPhoneNumber(String phoneNumber, Function(String) codeSent,
      Function(String) verificationFailed) async {
    try {
      log('Verifying phone number');
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (auth.PhoneAuthCredential credential) async {
          // Auto-retrieval or instant verification succeeded.
          await _auth.signInWithCredential(credential);
          log('Phone number automatically verified and user signed in');
          showToast('Phone number automatically verified and user signed in');
        },
        verificationFailed: (auth.FirebaseAuthException e) {
          log('Verification Faild for $phoneNumber');
          showToast(
              '##################Phone number verification failed: ${e.message}');
          log('######################Phone number verification failed: ${e.message}');
          verificationFailed(e.message ?? 'Unknown error');
        },
        codeSent: (String verificationId, int? resendToken) {
          log('Verification code sent to $phoneNumber');
          showToast('Verification code sent to $phoneNumber');
          codeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-retrieval timeout.
          showToast('Code auto-retrieval timeout');
        },
      );
    } catch (e) {
      showToast('Failed to verify phone number: $e');

      log('########################$e');
      verificationFailed(e.toString());
    }
  }

  Future<UserModel?> signInWithPhoneNumber(
      String verificationId, String smsCode) async {
    try {
      final auth.AuthCredential credential = auth.PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      auth.UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      auth.User? user = userCredential.user;
      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> doc =
            await _db.collection('users').doc(user.uid).get();
        UserModel userModel;
        if (doc.exists) {
          userModel = UserModel.fromSnapshot(doc.data()!);
        } else {
          userModel =
              UserModel(id: user.uid, name: '', email: '', password: '');
          await _db.collection('users').doc(user.uid).set(userModel.toJson());
        }
        await LoginManager.saveUser(userModel);
        return userModel;
      }
    } catch (e) {
      showToast('Failed to sign in with phone number: $e');
      return null;
    }
    return null;
  }
}
