import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/core/extensions.dart';
import 'package:go_shop/core/utils/textstyle.dart';
import 'package:go_shop/features/auth/controllers/auth_controller.dart';
import 'package:go_shop/features/auth/view/profile_setup.dart';
import 'package:go_shop/features/auth/view/wrapper.dart';
import 'package:go_shop/features/bottom_nav/bottom_nav_screen.dart';
import 'package:go_shop/features/home/view/home_screen.dart';
import 'package:go_shop/features/profile/view/profile.dart';
import 'package:go_shop/models/auth_state.dart';
import 'package:go_shop/services/dependencies.dart';
import 'package:go_shop/services/onboarding_settings.dart';
import 'package:go_shop/shared/loader.dart';
import 'package:go_shop/shared/flushbar.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sizer/sizer.dart';

class AuthScreen extends ConsumerStatefulWidget {
  static const route = '/auth';
  const AuthScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _isSignUp = true;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authNotifierProvider, (_, next) {
      log(next.toString());
      if (next is AuthFailure) {
        log(next.toString());
        displayFlushBar(context, next.error, isError: true);
        ref.read(authNotifierProvider.notifier).reset();
      }

      if (next is AuthSuccess) {
        if (locator.get<FirebaseAuth>().currentUser!.displayName == null) {
          context.go(ProfileSetup.route);
        } else {
          context.go(HomeScreen.route);
        }
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AutofillGroup(
                child: Column(
                  children: [
                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: Duration(seconds: 2),
                      builder: (context, opaque, _) {
                        return Opacity(
                          opacity: opaque,
                          child: SvgPicture.asset(
                            'assets/images/go_shop.svg',
                            placeholderBuilder: (context) {
                              return SizedBox(height: 30.h);
                            },
                          ),
                        );
                      },
                    ),
                    ShadInputFormField(
                      autofillHints: [AutofillHints.email],
                      controller: _emailController,
                      onPressedOutside:
                          (event) => FocusScope.of(context).unfocus(),
                      padding: EdgeInsets.all(14),
                      placeholder: Text("Email"),
                      textInputAction: TextInputAction.next,
                      validator: _validateEmail,
                      decoration: ShadDecoration(
                        color: Colors.grey[200],
                        border: ShadBorder(
                          padding: EdgeInsets.all(4),
                          radius: BorderRadius.circular(12),
                        ),
                        focusedBorder: ShadBorder(
                          padding: EdgeInsets.all(4),
                          radius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    ShadInputFormField(
                      autofillHints: [AutofillHints.password],
                      placeholder: Text("Password"),
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      onPressedOutside:
                          (event) => FocusScope.of(context).unfocus(),
                      textInputAction: TextInputAction.done,
                      validator: _validatePassword,
                      trailing: InkWell(
                        onTap:
                            () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                        child: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                      padding: EdgeInsets.all(14),
                      decoration: ShadDecoration(
                        color: Colors.grey[200],
                        border: ShadBorder(
                          padding: EdgeInsets.all(4),
                          radius: BorderRadius.circular(12),
                        ),
                        focusedBorder: ShadBorder(
                          padding: EdgeInsets.all(4),
                          radius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    ListenableBuilder(
                      listenable: Listenable.merge([
                        _emailController,
                        _passwordController,
                      ]),
                      builder: (context, _) {
                        return ShadButton(
                          width: 100.w,
                          height: 50,
                          enabled:
                              _emailController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _isSignUp
                                  ? ref
                                      .read(authNotifierProvider.notifier)
                                      .signUp(
                                        _emailController.text.trim(),
                                        _passwordController.text.trim(),
                                      )
                                  : ref
                                      .read(authNotifierProvider.notifier)
                                      .signIn(
                                        _emailController.text.trim(),
                                        _passwordController.text.trim(),
                                      );
                            }
                          },
                          child: Text(
                            _isSignUp ? "Sign Up" : "Sign in",
                            style: kTextStyle(16, color: Colors.white),
                          ),
                        );
                      },
                    ),
                    Text.rich(
                      TextSpan(
                        text:
                            _isSignUp
                                ? "Already have an account"
                                : "Don't have an account",
                        style: kTextStyle(14),
                        children: [
                          TextSpan(
                            text: _isSignUp ? " Sign in" : " Sign up",
                            style: kTextStyle(
                              14,
                              color: Theme.of(context).primaryColor,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    setState(() {
                                      _isSignUp = !_isSignUp;
                                    });
                                  },
                          ),
                        ],
                      ),
                    ).padY(8),
                    ShadButton(
                      width: 100.w,
                      height: 50,
                      onPressed: () {},
                      leading: Icon(Iconsax.google_1, size: 24),
                      child: Text("Sign in with google"),
                    ),
                  ],
                ).padX(15),
              ),
              if (ref.watch(authNotifierProvider) is AuthLoading) Loader(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
