import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_shop/core/collection_paths.dart';
import 'package:go_shop/models/auth_exception.dart';
import 'package:go_shop/models/user.dart';
import 'package:go_shop/services/dependencies.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final FirebaseFirestore firebaseFirestore;

  AuthRepository({
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.firebaseFirestore,
  });

  Future<bool> userDataIsSaved() async {
    try {
      final userDoc =
          await firebaseFirestore
              .collection(CollectionPaths.users)
              .doc(firebaseAuth.currentUser!.uid)
              .get();
      return userDoc.exists;
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<GoShopUser> saveUserData(String? name, int? phoneNumber) async {
    try {
      GoShopUser user = GoShopUser(
        uid: firebaseAuth.currentUser!.uid,
        name: name,
        email: firebaseAuth.currentUser!.email,
        phoneNumber: phoneNumber,
      );
      await firebaseFirestore
          .collection(CollectionPaths.users)
          .doc(user.uid)
          .set(user.toMap());
      return user;
    } catch (e) {
      log(e.toString());
      throw Exception("Error saving data");
    }
  }

  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final userCred = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCred;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw AuthException(
            'This email is already registered. Please sign in instead.',
          );
        case 'invalid-email':
          throw AuthException('Please enter a valid email address.');
        case 'operation-not-allowed':
          throw AuthException(
            'Email/password accounts are not enabled. Please contact support.',
          );
        case 'weak-password':
          throw AuthException(
            'The password is too weak. Please use a stronger password.',
          );
        default:
          throw AuthException(
            'An error occurred during sign up. Please try again.',
          );
      }
    } catch (e) {
      throw AuthException('An unexpected error occurred. Please try again.');
    }
  }

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw AuthException(
            'No account found with this email. Please sign up first.',
          );
        case 'wrong-password':
          throw AuthException('Incorrect password. Please try again.');
        case 'invalid-email':
          throw AuthException('Please enter a valid email address.');
        case 'user-disabled':
          throw AuthException(
            'This account has been disabled. Please contact support.',
          );
        default:
          throw AuthException(
            'An error occurred during sign in. Please try again.',
          );
      }
    } catch (e) {
      throw AuthException('An unexpected error occurred. Please try again.');
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();


      final GoogleSignInAuthentication googleAuth =
           googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      return await firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await Future.wait([firebaseAuth.signOut(), googleSignIn.signOut()]);
    } catch (e) {
      throw AuthException(
        'An error occurred while signing out. Please try again.',
      );
    }
  }
}
