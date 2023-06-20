import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_shop/models/category_model.dart';
import 'package:go_shop/models/customer.dart';
import 'package:go_shop/models/product.dart';
import 'package:go_shop/providers/auth_service.dart';
import 'package:go_shop/routes.dart';
import 'package:go_shop/screen/auth/wrapper.dart';
import 'package:go_shop/services/database.dart';
import 'package:provider/provider.dart';
import 'package:go_shop/providers/theme_provider.dart';
import 'package:go_shop/theme/theme.dart';
import 'providers/cart_provider.dart';
import '/services/theme_prefs.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ThemeSettings().init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AuthService(),
      ),
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
      ),
      StreamProvider<Customer?>.value(
        value: DatabaseService.getCustomer(),
        initialData: null,
      ),
      StreamProvider<List<Category>>.value(
        value: DatabaseService().getCategories(),
        initialData: [],
      ),
      StreamProvider<Iterable<Product>>.value(
        value: DatabaseService().fetchProducts(),
        initialData: [],
      )
    ],
    child: Builder(builder: (context) {
      bool themeStatus = Provider.of<ThemeProvider>(context).themeStatus;
      return MaterialApp(
        home: const MyApp(),
        debugShowCheckedModeBanner: false,
        theme: MyTheme.themeData(context, themeStatus),
        routes: AppRoutes.routes,
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
    return const Wrapper();
  }
}
