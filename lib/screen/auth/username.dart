import 'package:flutter/material.dart';
import 'package:go_shop/constants/consts.dart';
import 'package:go_shop/screen/bottom_nav_bar/bottom_bar.dart';
import 'package:go_shop/services/database.dart';
import 'package:go_shop/widgets/spacings.dart';
import 'package:go_shop/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Username",
                style: kTextStyle(30, context, true),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: displayNameController,
                        decoration: InputDecoration(
                          hintText: "name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (val) =>
                            val!.isEmpty ? "please enter your name" : null,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: size.width,
                height: size.height / 14,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    formKey.currentState!.validate()
                        ? {
                            formKey.currentState!.save(),
                            await authService.user!
                                .updateDisplayName(displayNameController.text),
                            databaseService.createCustomer(),
                          }
                        : null;
                  },
                  child: const Text("proceed"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}