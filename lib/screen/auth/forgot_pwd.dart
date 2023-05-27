import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:go_shop/services/utils.dart';
import 'package:go_shop/widgets/spacings.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPwdScreen extends StatefulWidget {
  static const routeName = "/forgotpwd";
  const ForgotPwdScreen({Key? key}) : super(key: key);
  @override
  State<ForgotPwdScreen> createState() => _ForgotPwdScreenState();
}

class _ForgotPwdScreenState extends State<ForgotPwdScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
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
                color: Utils(context).isDark ? Colors.grey[300] : Colors.black,
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
                  const TextField(
                    decoration: InputDecoration(
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
                    onPressed: () {},
                    child: Text("Reset password"),
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
