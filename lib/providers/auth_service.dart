import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_shop/screen/bottom_nav_bar/bottom_bar.dart';
import 'package:go_shop/services/database.dart';
import '../widgets/error_dialog.dart';

class AuthService extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool isLoading = false;
  String? error;

  String? get userid => firebaseAuth.currentUser!.uid;

  User? get user => firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<void> signInAnon(BuildContext context) async {
    try {
      await firebaseAuth.signInAnonymously();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => BottomBarScreen()),
          (route) => false);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> signIn(
      BuildContext context, String email, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      isLoading = false;
      notifyListeners();
      // ignore: use_build_context_synchronously
    } on FirebaseException catch (e) {
      isLoading = false;
      notifyListeners();
      if (e.code == 'user-not-found') {
        error = "User not found";
      } else if (e.code == "wrong-password") {
        error = "Incorrect password";
      } else if (e.code == "network-request-failed") {
        error = "A network occured, check your internet settings";
      } else {
        error = e.message.toString();
      }
      showErrorDialog(context, error!);
      error = '';
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<void> signUp(
      BuildContext context, String email, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      isLoading = false;
      notifyListeners();
    } on FirebaseException catch (e) {
      isLoading = false;
      notifyListeners();
      if (e.code == 'email-already-in-use') {
        error = "email already in use";
      } else if (e.code == "network-request-failed") {
        error = "A network occured, check your internet settings";
      } else {
        error = e.message.toString();
      }
      showErrorDialog(context, error!);
    }
  }
}
