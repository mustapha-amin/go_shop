// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:go_shop/providers/theme_provider.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
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
                      text: "Name",
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
              child: Text("test@email.com"),
            ),
            Divider(),
            ListTile(
              title: Text("Address"),
              subtitle: Text(address),
              leading: Icon(Icons.person),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
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
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
            ListTile(
              title: Text("WishList"),
              leading: Icon(Icons.shopping_bag_sharp),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
            ListTile(
              title: Text("Viewed products"),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
            SwitchListTile(
              title: Text(theme.themeStatus ? "Dark mode" : "Light mode"),
              value: theme.themeStatus,
              onChanged: (val) {
                context.read<ThemeProvider>().toggleTheme();
              },
              secondary: Icon(theme.themeStatus
                  ? Icons.dark_mode
                  : Icons.light_mode_outlined),
            ),
            ListTile(
              title: Text("Forgot password"),
              leading: Icon(Icons.lock),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
            ListTile(
              title: Text("Logout"),
              leading: Icon(Icons.logout),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              onTap: () {
                showDialog(
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
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Yes")),
                        ],
                      );
                    });
              },
            ),
          ],
        ));
  }
}
