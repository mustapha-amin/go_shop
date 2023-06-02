import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_shop/screen/auth/forgot_pwd.dart';
import 'package:go_shop/services/utils.dart';
import 'package:go_shop/widgets/loading_widget.dart';
import 'package:go_shop/widgets/error_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/google_button.dart';
import '../../constants/consts.dart';
import '../../services/auth_service.dart';
import '../../widgets/spacings.dart';
import '../../widgets/button.dart';
import 'signup.dart';

class LogInScreen extends StatefulWidget {
  static const routeName = "/login";
  const LogInScreen({Key? key}) : super(key: key);
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  AuthService authService = AuthService();
  static String basePath = 'assets/images/general';
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  late FocusNode passwordFocusNode, emailFocusNode;
  bool loading = false;
  String error = '';
  Color buttonColor = Colors.grey;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    super.initState();
  }

  void passwordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void signIn() async {
    setState(() {
      loading = true;
    });
    try {
      await authService.firebaseAuth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    } on FirebaseException catch (e) {
      setState(() {
        loading = false;
      });
      if (e.code == 'user-not-found') {
        setState(() {
          loading = false;
          error = "User not found";
        });
        showErrorDialog(context, error);
      } else if (e.code == "wrong-password") {
        setState(() {
          loading = false;
          error = "Incorrect password";
        });
        showErrorDialog(context, error);
      } else if (e.code == "network-request-failed") {
        setState(() {
          loading = false;
          error = "A network occured, check your internet settings";
        });
        showErrorDialog(context, error);
      } else {
        setState(() {
          loading = false;
          error = e.message.toString();
        });
        showErrorDialog(context, error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return loading
        ? const LoadingWidget()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back",
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(fontSize: 30),
                        ),
                      ),
                      addVerticalSpacing(10),
                      Text(
                        "Sign in to your account",
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                      ),
                      addVerticalSpacing(20),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          focusNode: emailFocusNode,
                          decoration: InputDecoration(
                            hintText: "email",
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            filled: true,
                            fillColor: Utils(context).isDark
                                ? Colors.grey[300]
                                : Colors.white,
                            suffixIcon: const Icon(Icons.email),
                          ),
                          onChanged: (_) =>
                              _passwordController.text.isNotEmpty &&
                                      _emailController.text.isNotEmpty
                                  ? buttonColor = Theme.of(context).primaryColor
                                  : Colors.grey,
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) =>
                              val!.isNotEmpty ? null : "Enter an email",
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(emailFocusNode),
                          controller: _emailController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          focusNode: passwordFocusNode,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                            filled: true,
                            hintText: "password",
                            fillColor: Utils(context).isDark
                                ? Colors.grey[300]
                                : Colors.white,
                            suffixIcon: GestureDetector(
                              onTap: passwordVisibility,
                              child: Icon(
                                obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          onChanged: (_) => _passwordController
                                      .text.isNotEmpty &&
                                  _emailController.text.isNotEmpty
                              ? setState(() {
                                  buttonColor = Theme.of(context).primaryColor;
                                })
                              : setState(() {
                                  buttonColor = Colors.grey;
                                }),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) =>
                              val!.isNotEmpty ? null : "Enter a password",
                          onFieldSubmitted: (_) =>
                              FocusScope.of(context).unfocus(),
                          obscureText: obscureText,
                          controller: _passwordController,
                        ),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, ForgotPwdScreen.routeName);
                          },
                          child: const Text("Forgot passsword?"),
                        ),
                      ),

                      AppButton(
                        height: size.height / 13,
                        labelText: "Log In",
                        isElevated: true,
                        onTap: () =>
                            _formKey.currentState!.validate() ? signIn() : null,
                      ),
                      // add google logo later
                      addVerticalSpacing(10),
                      GoogleButton(size: size, basePath: basePath),
                      addVerticalSpacing(5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 2,
                              width: size.width / 2.6,
                              color: Colors.black,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Text("OR"),
                            ),
                            Container(
                              height: 2,
                              width: size.width / 2.6,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.white,
                            fixedSize: Size(size.width, size.height / 15)),
                        onPressed: () async {
                          await authService.firebaseAuth.signInAnonymously();
                        },
                        child: Text(
                          "Continue as guest",
                          style: kTextStyle(15, context),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account? "),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  SignUpScreen.routeName,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
