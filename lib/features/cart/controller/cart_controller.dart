import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop/features/cart/repository/cart_repository.dart';
import 'package:go_shop/models/cart_item.dart';
import 'package:go_shop/services/dependencies.dart';

final cartControllerProvider =
    AsyncNotifierProvider<CartController, List<CartItem>>(
      () => CartController(
        cartRepository: locator.get<CartRepository>(),
      ),
    );

class CartController extends AsyncNotifier<List<CartItem>> {
  late final CartRepository cartRepository;

  CartController({required this.cartRepository});

  @override
  Future<List<CartItem>> build() async {
    return await cartRepository.getCartItems();
  }

  Future<void> clearCart() async {
    state = const AsyncValue.loading();
    try {
      await cartRepository.clearCart();
      state = AsyncValue.data([]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateItem(CartItem item) async {
    state = const AsyncValue.loading();
    try {
      await cartRepository.updateCart(item);
      final currentItems = state.value ?? [];
      final updatedItems =
          currentItems.map((i) => i.id == item.id ? item : i).toList();
      state = AsyncValue.data(updatedItems);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addItem(CartItem item) async {
    state = const AsyncValue.loading();
    try {
      await cartRepository.addCartItem(item);
      final currentItems = state.value ?? [];
      state = AsyncValue.data([...currentItems, item]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> removeItem(String itemId) async {
    state = const AsyncValue.loading();
    try {
      await cartRepository.removeCartItem(itemId);
      final currentItems = state.value ?? [];
      state = AsyncValue.data(
        currentItems.where((item) => item.id != itemId).toList(),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  int quantityInCart(String id) {
    final currentItems = state.value ?? [];
    final item = currentItems.firstWhere(
      (item) => item.productID == id,
      orElse: () => CartItem(),
    );
    return item.quantity ?? 0;
  }

  bool itemInCart(String id) {
    final currentItems = state.value ?? [];
    return currentItems.any((item) => item.productID == id);
  }
}
