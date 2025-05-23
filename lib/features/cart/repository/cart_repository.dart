import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_shop/core/collection_paths.dart';
import 'package:go_shop/models/cart_item.dart';

class CartRepository {
  final FirebaseFirestore firebaseFirestore;
  final String userId;

  CartRepository({
    required this.firebaseFirestore,
    required this.userId,
  });

Future<void> updateCart(CartItem cartItem) async {
    await firebaseFirestore
        .collection(CollectionPaths.users)
        .doc(userId)
        .collection(CollectionPaths.cart)
        .doc(cartItem.id)
        .update(cartItem.toJson());
  }

  Future<void> addCartItem(CartItem cartItem) async {
    await firebaseFirestore
        .collection(CollectionPaths.users)
        .doc(userId)
        .collection(CollectionPaths.cart)
        .doc(cartItem.id)
        .set(cartItem.toJson());
  }

  Future<void> removeCartItem(String id) async {
    await firebaseFirestore
        .collection(CollectionPaths.users)
        .doc(userId)
        .collection(CollectionPaths.cart)
        .doc(id)
        .delete();
  }  

  Future<List<CartItem>> getCartItems() async {
    final cartItemsSnapshot = await firebaseFirestore
        .collection(CollectionPaths.users)
        .doc(userId)
        .collection(CollectionPaths.cart)
        .get();

    return cartItemsSnapshot.docs
        .map((doc) => CartItem.fromJson(doc.data()))
        .toList();
  }

  Future<void> clearCart() async {
    final cartItemsSnapshot = await firebaseFirestore
        .collection(CollectionPaths.users)
        .doc(userId)
        .collection(CollectionPaths.cart)
        .get();

    for (var doc in cartItemsSnapshot.docs) {
      await doc.reference.delete();
    }
  }
}
