import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/core/providers.dart';
import 'package:go_shop/features/auth/repository/auth_repository.dart';
import 'package:go_shop/features/auth/view/auth_screen.dart';
import 'package:go_shop/models/auth_state.dart';
import 'package:go_shop/services/dependencies.dart';
import 'package:go_shop/services/onboarding_settings.dart';

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((
  ref,
) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthInitial());

  void reset() {
    state = AuthInitial();
  }

  Future<void> signIn(String email, String password) async {
    state = AuthLoading();
    try {
      await locator.get<AuthRepository>().signIn(
        email: email,
        password: password,
      );
      state = AuthSuccess();
    } catch (e) {
      state = AuthFailure(error: e.toString());
    }
  }

  Future<void> signUp(String email, String password) async {
    state = AuthLoading();
    try {
      await locator.get<AuthRepository>().signUp(
        email: email,
        password: password,
      );
      state = AuthSuccess();
    } catch (e) {
      state = AuthFailure(error: e.toString());
    }
  }

  Future<void> signinGoogle() async {
    try {
      state = AuthLoading();
      await locator.get<AuthRepository>().signInWithGoogle();
      state = AuthSuccess();
    } catch (e) {
      state = AuthFailure(error: e.toString());
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      state = AuthLoading();
      await locator.get<AuthRepository>().signOut();
      state = AuthSuccess();
      context.go(AuthScreen.route);
    } catch (e) {
      state = AuthFailure(error: e.toString());
    }
  }

  Future<void> saveUserData(String? name, int? phoneNumber) async {
    try {
      state = AuthLoading();
      await locator.get<AuthRepository>().saveUserData(name, phoneNumber);
      await locator.get<FirebaseAuth>().currentUser!.updateDisplayName(name);
      await locator.get<OnboardingSettings>().setDetailsSaved(true);
      state = AuthSuccess();
    } catch (e) {
      state = AuthFailure(error: e.toString());
    }
  }

  Future<void> userDataIsSaved() async {
    try {
      state = AuthLoading();
      final exists = await locator.get<AuthRepository>().userDataIsSaved();
      state = exists ? AuthSuccess() : AuthFailure(error: 'error');
    } catch (e) {
      state = AuthFailure(error: 'error');
      throw Exception(e.toString());
    }
  }
}
