import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_shop/screen/auth/login.dart';
import 'package:go_shop/screen/auth/username.dart';
import 'package:go_shop/providers/auth_service.dart';
import 'package:go_shop/widgets/loading_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../constants/consts.dart';
import '../../widgets/button.dart';
import '../../widgets/error_dialog.dart';
import '../../widgets/spacings.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "/signup";
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AuthService authService = AuthService();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  ValueNotifier<String> emailErrorMessage = ValueNotifier<String>('');
  ValueNotifier<String> passwordErrorMessage = ValueNotifier<String>('');
  ValueNotifier<String> confirmPasswordError = ValueNotifier<String>('');
  ValueNotifier<bool> fieldsFilled = ValueNotifier<bool>(false);
  bool obscureText = false;
  final _formKey = GlobalKey<FormState>();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();
  bool loading = false;
  String error = '';

  void _validateEmail() {
    String value = _emailController.text;
    if (value.isEmpty) {
      emailErrorMessage.value = 'Email cannot be empty!';
    } else if (!emailRegex.hasMatch(value)) {
      emailErrorMessage.value = 'Invalid email address!';
    } else {
      emailErrorMessage.value = '';
    }
  }

  void _validatePassword() {
    String value = _passwordController.text;
    if (value.isEmpty) {
      passwordErrorMessage.value = 'Password cannot be empty!';
    } else if (value.length < 8) {
      passwordErrorMessage.value =
          'Password must be at least 8 characters long!';
    } else if (!passwordRegex.hasMatch(value)) {
      passwordErrorMessage.value =
          'Password must contain at least a number, symbol, and letter.';
    } else {
      passwordErrorMessage.value = '';
    }
  }

  void _comparePasswords() {
    String value1 = _passwordController.text;
    String value2 = _confirmPasswordController.text;
    if (value1.compareTo(value2) == 0) {
      confirmPasswordError.value = '';
    } else {
      confirmPasswordError.value = 'Password do not match';
    }
  }

  void passwordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    super.initState();
  }

  void registerUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        loading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthService>(context);
    var size = MediaQuery.of(context).size;
    return provider.isLoading
        ? const LoadingWidget()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create an account:",
                            style: GoogleFonts.lato(
                              textStyle: kTextStyle(25, context),
                            ),
                          ),
                          addVerticalSpacing(40),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: ValueListenableBuilder(
                              valueListenable: emailErrorMessage,
                              builder: (context, value, child) {
                                return TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "email",
                                    errorText: emailErrorMessage.value,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    errorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    focusedErrorBorder:
                                        const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.green,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    suffixIcon: const Icon(Icons.email),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (_) => _validateEmail(),
                                  controller: _emailController,
                                  focusNode: emailFocusNode,
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: ValueListenableBuilder(
                              valueListenable: passwordErrorMessage,
                              builder: (context, value, child) {
                                return TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(
                                      RegExp(r'\s'),
                                    ),
                                  ],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    errorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    focusedErrorBorder:
                                        const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.green,
                                      ),
                                    ),
                                    filled: true,
                                    errorText: passwordErrorMessage.value,
                                    errorMaxLines: 2,
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
                                  onChanged: (_) => {
                                    _confirmPasswordController.text.isEmpty
                                        ? null
                                        : _comparePasswords(),
                                    _validatePassword(),
                                  },
                                  obscureText: obscureText,
                                  controller: _passwordController,
                                  focusNode: passwordFocusNode,
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: ValueListenableBuilder(
                              valueListenable: confirmPasswordError,
                              builder: (context, value, child) {
                                return TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(
                                      RegExp(r'\s'),
                                    ),
                                  ],
                                  decoration: InputDecoration(
                                    errorText: confirmPasswordError.value,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    errorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    focusedErrorBorder:
                                        const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.green,
                                      ),
                                    ),
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
                                  onChanged: (_) => _comparePasswords(),
                                  obscureText: obscureText,
                                  controller: _confirmPasswordController,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppButton(
                            height: size.height / 12,
                            isElevated: true,
                            labelText: "Sign Up",
                            onTap: () => _formKey.currentState!.validate()
                                ? provider.signUp(
                                    context,
                                    _emailController.text,
                                    _passwordController.text,
                                  )
                                : null,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already have an account? "),
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
                                        color: Theme.of(context).primaryColor,
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
            ),
          );
  }
}
