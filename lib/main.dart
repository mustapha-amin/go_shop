import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/core/router.dart';
import 'package:go_shop/features/onboarding/view/onboarding_screen.dart';
import 'package:go_shop/firebase_options.dart';
import 'package:go_shop/services/dependencies.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent),
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  setUpDeps();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Sizer(
      builder: (_, _, _) {
        return ShadApp.router(
          theme: ShadThemeData(
            colorScheme: ShadVioletColorScheme.light(),
            brightness: Brightness.light,
          ),
          routerConfig: ref.read(appRoutes),
        );
      },
    );
  }
}
