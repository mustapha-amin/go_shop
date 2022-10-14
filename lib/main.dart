import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_shop/providers/theme_provider.dart';
import 'package:go_shop/theme/theme.dart';
import 'screen/bottom_bar.dart';
import '/services/theme_prefs.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeSettings().init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
      )
    ],
    child: Builder(
      builder: (context) {
        bool themeStatus = Provider.of<ThemeProvider>(context).themeStatus;
        return MaterialApp(
          home: const MyApp(),
          debugShowCheckedModeBanner: false,
          theme: MyTheme.themeData(context, themeStatus),
        );
      }
    ),
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
    return const BottomBarScreen();
  }
}
