import 'package:flutter/material.dart';
import 'package:go_shop/screen/auth/forgot_pwd.dart';
import 'package:go_shop/screen/bottom_nav_bar/bottom_bar.dart';
import 'package:go_shop/services/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/spacings.dart';
import 'signup.dart';

class LogInScreen extends StatefulWidget {
  static const routeName = "/login";
  const LogInScreen({Key? key}) : super(key: key);
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  static String basePath = 'assets/images/general';
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  bool obscureText = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  void passwordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
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
                    decoration: InputDecoration(
                      hintText: "email",
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Utils(context).isDark
                          ? Colors.grey[300]
                          : Colors.white,
                      suffixIcon: const Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) => val!.isEmpty ? "Enter an email" : null,
                    controller: _emailController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: true,
                      hintText: "password",
                      fillColor: Utils(context).isDark
                          ? Colors.grey[300]
                          : Colors.white,
                      suffixIcon: GestureDetector(
                        onTap: passwordVisibility,
                        child: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                    ),
                    obscureText: obscureText,
                    validator: (val) =>
                        val!.length < 6 ? "Enter your password" : null,
                    controller: _passwordController,
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ForgotPwdScreen.routeName);
                    },
                    child: const Text("Forgot passsword?"),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: _emailController.text.isEmpty &&
                              _passwordController.text.isEmpty
                          ? Colors.grey
                          : Colors.blue,
                      fixedSize: Size(size.width, size.height / 15)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  child: const Text("Log in"),
                ),

                // add google logo later
                addVerticalSpacing(10),
                TextButton(
                  style: TextButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.black,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color.fromARGB(255, 242, 246, 245),
                      fixedSize: Size(size.width, size.height / 15)),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        '$basePath/google.png',
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          "Sign in with Google",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Utils(context).isDark
                          ? Colors.blue[700]
                          : Colors.black,
                      fixedSize: Size(size.width, size.height / 15)),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return const BottomBarScreen();
                    }));
                  },
                  child: const Text("Continue as guest"),
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
                              color: Colors.blue[800],
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
}
