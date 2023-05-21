import 'package:flutter/material.dart';
import 'package:go_shop/auth/forgot_pwd.dart';
import 'package:go_shop/auth/login.dart';
import 'package:go_shop/auth/signup.dart';
import 'package:go_shop/providers/wishlist_provider.dart';
import 'package:go_shop/routes.dart';
import 'package:go_shop/screen/inner_screens/on_sale.dart';
import 'package:go_shop/screen/inner_screens/wishlist.dart';
import 'package:provider/provider.dart';
import 'package:go_shop/providers/theme_provider.dart';
import 'package:go_shop/theme/theme.dart';
import 'providers/cart_provider.dart';
import 'screen/bottom_nav_bar/bottom_bar.dart';
import '/services/theme_prefs.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeSettings().init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => CartProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => WishlistProvider(),
      ),
    ],
    child: Builder(builder: (context) {
      bool themeStatus = Provider.of<ThemeProvider>(context).themeStatus;
      return MaterialApp(
        home: const MyApp(),
        debugShowCheckedModeBanner: false,
        theme: MyTheme.themeData(context, themeStatus),
        routes: AppRoutes.routes
        
      );
    }),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LogInScreen();
  }
}
