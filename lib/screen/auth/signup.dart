import 'package:flutter/material.dart';
import 'package:go_shop/screen/auth/login.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/spacings.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "/signup";
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool obscureText = false;

  void passwordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create an account:",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(fontSize: 30),
                    ),
                  ),
                  addVerticalSpacing(40),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: const Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) =>
                          val!.isEmpty ? "Enter an email" : null,
                      controller: _emailController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        hintText: "password",
                        fillColor: Colors.white,
                        suffixIcon: GestureDetector(
                          onTap: passwordVisibility,
                          child: Icon(
                            obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      obscureText: obscureText,
                      validator: (val) =>
                          val!.length < 6 ? "Enter your password" : null,
                      controller: _passwordController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        hintText: "confirm password",
                        fillColor: Colors.white,
                        suffixIcon: GestureDetector(
                          onTap: passwordVisibility,
                          child: Icon(
                            obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      obscureText: obscureText,
                      validator: (val) =>
                          val!.length < 6 ? "Enter your password" : null,
                      controller: _passwordController,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fixedSize: Size(size.width, size.height / 12),
                      backgroundColor: Colors.blue[800],
                    ),
                    onPressed: () {},
                    child: const Text("Sign up"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? "),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              LogInScreen.routeName,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                color: Colors.blue[800],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
