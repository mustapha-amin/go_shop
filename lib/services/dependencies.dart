import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:go_shop/core/providers.dart';
import 'package:go_shop/features/auth/repository/auth_repository.dart';
import 'package:go_shop/features/bottom_nav/repository/product_repository.dart';
import 'package:go_shop/features/cart/repository/cart_repository.dart';
import 'package:go_shop/features/cart/repository/payment_repository.dart';
import 'package:go_shop/services/onboarding_settings.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> setUpDeps() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  

  locator
    ..registerSingleton<FirebaseAuth>(FirebaseAuth.instance)
    ..registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance)
    ..registerSingleton<SharedPreferences>(sharedPreferences)
    ..registerSingleton<GoogleSignIn>(GoogleSignIn.instance)
    ..registerLazySingleton<OnboardingSettings>(
      () => OnboardingSettings(locator.get<SharedPreferences>()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepository(
        firebaseAuth: locator.get<FirebaseAuth>(),
        googleSignIn: locator.get<GoogleSignIn>(),
        firebaseFirestore: locator.get<FirebaseFirestore>(),
      ),
    )
    ..registerLazySingleton(
      () => ProductRepository(firestore: locator.get<FirebaseFirestore>()),
    )
    ..registerLazySingleton(
      () => CartRepository(firebaseFirestore: locator.get<FirebaseFirestore>(), userId: locator.get<FirebaseAuth>().currentUser!.uid),
    )..registerLazySingleton(() => PaymentRepository());
}
