import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop/core/collection_paths.dart';
import 'package:go_shop/models/cart_item.dart';
import 'package:go_shop/models/user.dart';
import 'package:go_shop/services/dependencies.dart';
import 'package:go_shop/services/onboarding_settings.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<User?> _subscription;

  GoRouterRefreshStream(Stream<User?> stream) {
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final currentUserNotifierProvider =
    StreamNotifierProvider<CurrentUserNotifier, GoShopUser>(
      () => CurrentUserNotifier(
        locator.get<FirebaseFirestore>(),
        locator.get<FirebaseAuth>(),
      ),
    );

class CurrentUserNotifier extends StreamNotifier<GoShopUser> {
  FirebaseFirestore firebaseFirestore;
  FirebaseAuth firebaseAuth;
  CurrentUserNotifier(this.firebaseFirestore, this.firebaseAuth);

  @override
  Stream<GoShopUser> build() {
    return firebaseFirestore
        .collection(CollectionPaths.users)
        .doc(firebaseAuth.currentUser!.uid)
        .snapshots()
        .map((snap) => GoShopUser.fromMap(snap.data()!));
  }

  GoShopUser get currentUser => state.value!;

  Future<void> updateUser(GoShopUser user) async {
    state = const AsyncLoading();
    try {
      await firebaseFirestore
          .collection(CollectionPaths.users)
          .doc(firebaseAuth.currentUser!.uid)
          .update(user.toMap());
      state = AsyncData(user);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final appIsLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

void toggleLoader(WidgetRef ref, bool value) {
  ref.read(appIsLoadingProvider.notifier).state = value;
}
