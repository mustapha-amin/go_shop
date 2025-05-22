import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop/core/collection_paths.dart';
import 'package:go_shop/models/user.dart';
import 'package:go_shop/services/dependencies.dart';

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

  Future<void> updateCart(String? id) async {
    await firebaseFirestore
        .collection(CollectionPaths.users)
        .doc(firebaseAuth.currentUser!.uid)
        .update({
          'cart':
              state.value!.cart.contains(id)
                  ? FieldValue.arrayRemove([id])
                  : FieldValue.arrayUnion([id]),
        });
    ref.invalidateSelf();
  }
}

final appIsLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

void toggleLoader(WidgetRef ref, bool value) {
  ref.read(appIsLoadingProvider.notifier).state = value;
}
