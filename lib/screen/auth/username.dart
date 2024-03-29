import 'package:flutter/material.dart';
import 'package:go_shop/constants/consts.dart';
import 'package:go_shop/screen/bottom_nav_bar/bottom_bar.dart';
import 'package:go_shop/services/database.dart';
import 'package:go_shop/providers/auth_service.dart';
import 'package:go_shop/widgets/loading_widget.dart';

class UserName extends StatefulWidget {
  const UserName({super.key});

  @override
  State<UserName> createState() => _UserNameState();
}

class _UserNameState extends State<UserName> {
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  DatabaseService? databaseService;
  bool isLoading = false;

  @override
  void initState() {
    databaseService = DatabaseService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: isLoading ? const LoadingWidget() : Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Username",
                style: kTextStyle(size: 30, isBold: true),
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
                            setState(() {
                              isLoading = true;
                            }),
                            await authService.user!
                                .updateDisplayName(displayNameController.text),
                            databaseService!.createCustomer(),
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BottomBarScreen(),
                              ),
                            )
                          }
                        : null;
                  },
                  child: const Text(
                    "proceed",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
