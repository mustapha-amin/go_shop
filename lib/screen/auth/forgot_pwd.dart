import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_shop/providers/auth_service.dart';
import 'package:go_shop/services/utils.dart';
import 'package:go_shop/widgets/error_dialog.dart';
import 'package:go_shop/widgets/loading_widget.dart';
import 'package:go_shop/widgets/spacings.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPwdScreen extends StatefulWidget {
  static const routeName = "/forgotpwd";
  const ForgotPwdScreen({Key? key}) : super(key: key);
  @override
  State<ForgotPwdScreen> createState() => _ForgotPwdScreenState();
}

class _ForgotPwdScreenState extends State<ForgotPwdScreen> {
  final TextEditingController emailController = TextEditingController();
  AuthService authService = AuthService();
  bool loading = false;

  Future<void> resetPassword() async {
    setState(() {
      loading = true;
    });
    try {
      await authService.firebaseAuth
          .sendPasswordResetEmail(
            email: emailController.text,
          )
          .whenComplete(() => {
                setState(() {
                  loading = false;
                }),
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Password reset link sent"),
                    duration: Duration(milliseconds: 500),
                  ),
                ),
              });
    } on FirebaseException catch (e) {
      setState(() {
        loading = false;
      });
      showErrorDialog(context, e.message!);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return loading
        ? const LoadingWidget()
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Forgot password",
                          style: GoogleFonts.lato(
                            fontSize: 30,
                          ),
                        ),
                        addVerticalSpacing(30),
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            hintText: "email",
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: Icon(Icons.email),
                          ),
                        ),
                        addVerticalSpacing(10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(size.width, size.height / 14),
                          ),
                          onPressed: () {
                            emailController.text.isEmpty
                                ? ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Enter your email"),
                                      duration: Duration(milliseconds: 500),
                                    ),
                                  )
                                : resetPassword();
                          },
                          child: const Text("Reset password"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
