// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_shop/constants/consts.dart';
import 'package:go_shop/screen/auth/login.dart';
import 'package:go_shop/screen/auth/wrapper.dart';
import 'package:go_shop/providers/auth_service.dart';
import 'package:go_shop/screen/inner_screens/orders_history_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          authService.user!.isAnonymous
              ? Text(
                  "Guest",
                  style: kTextStyle(size: 15),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 10.w,
                      child: Text(
                        authService.user!.displayName![0],
                        style: kTextStyle(size: 25, isBold: true),
                      ),
                    ),
                    Text(
                      authService.user!.displayName!,
                      style: kTextStyle(size: 20),
                    ),
                    Text(
                      authService.user!.email!,
                      style: kTextStyle(
                        size: 15,
                      ),
                    ),
                  ],
                ),
          Divider(),
          ListTile(
            title: Text("Orders"),
            leading: Icon(Icons.shopping_bag),
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return OrdersHistory();
            })),
          ),
          ListTile(
            title: Text("Wishlist"),
            leading: Icon(Icons.favorite),
          ),
          ListTile(
            title: Text("Forgot password"),
            leading: Icon(Icons.lock),
          ),
          ListTile(
            title: Text(authService.user!.isAnonymous ? "Login" : "Logout"),
            leading: Icon(
                authService.user!.isAnonymous ? Icons.login : Icons.logout),
            onTap: () {
              authService.user!.isAnonymous
                  ? Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LogInScreen()),
                      ModalRoute.withName(LogInScreen.routeName))
                  : showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Row(
                            children: const [
                              Icon(Icons.logout),
                              Text("Sign out"),
                            ],
                          ),
                          content: Text("Do you want to sign out"),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                context.read<AuthService>().signOut();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => Wrapper(),
                                    ),
                                    (route) => false);
                              },
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel"),
                            ),
                          ],
                        );
                      },
                    );
            },
          ),
        ],
      ),
    );
  }
}
