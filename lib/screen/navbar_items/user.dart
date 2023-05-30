// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_shop/constants/consts.dart';
import 'package:go_shop/screen/auth/login.dart';
import 'package:go_shop/screen/inner_screens/wishlist.dart';
import 'package:go_shop/services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:go_shop/providers/theme_provider.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  AuthService authService = AuthService();
  String address = "Not set";
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: ListView(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          constraints: BoxConstraints(
            maxHeight: size.width * .18,
          ),
          child: RichText(
            text: TextSpan(
              text: "Hi, ",
              style: GoogleFonts.lato(
                color: Colors.blue[600],
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: "${authService.user!.displayName}",
                  style: GoogleFonts.lato(
                    fontSize: 27,
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            authService.user != null ? authService.user!.email! : "Guest",
            style: kTextStyle(20, context),
          ),
        ),
        Divider(),
        ListTile(
          title: Text("Address"),
          subtitle: Text(
            address,
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
            ),
          ),
          leading: Icon(Icons.person),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Update address"),
                    content: TextField(
                      decoration: InputDecoration(
                        hintText: "Address",
                      ),
                      maxLines: 5,
                      controller: _textEditingController,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            address = _textEditingController.text;
                          });
                          Navigator.pop(context);
                        },
                        child: Text("Update"),
                      ),
                    ],
                  );
                });
          },
        ),
        ListTile(
          title: Text("Orders"),
          leading: Icon(Icons.shopping_bag),
        ),
        ListTile(
            title: Text("WishList"),
            leading: Icon(Icons.shopping_bag_sharp),
            onTap: () {
              Navigator.pushNamed(context, WishlistScreen.routeName);
            }),
        ListTile(
          title: Text("Viewed products"),
        ),
        SwitchListTile(
          title: Text(theme.themeStatus ? "Dark mode" : "Light mode"),
          value: theme.themeStatus,
          onChanged: (val) {
            context.read<ThemeProvider>().toggleTheme();
          },
          secondary: Icon(
              theme.themeStatus ? Icons.dark_mode : Icons.light_mode_outlined),
        ),
        ListTile(
          title: Text("Forgot password"),
          leading: Icon(Icons.lock),
        ),
        ListTile(
          title: Text(authService.user == null ? "Login" : "Logout"),
          leading: Icon(authService.user == null ? Icons.login : Icons.logout),
          onTap: () {
            authService.user == null
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
                              await authService.firebaseAuth.signOut();
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
                              child: Text("Cancel")),
                        ],
                      );
                    },
                  );
          },
        ),
      ],
    ));
  }
}
