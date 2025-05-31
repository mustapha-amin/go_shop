import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop/features/bottom_nav/repository/product_repository.dart';
import 'package:go_shop/models/product.dart';
import 'package:go_shop/services/dependencies.dart';

final getProductByIDProvider = FutureProvider.family<Product, String>((
  ref,
  id,
) async {
  return locator.get<ProductRepository>().getProductById(id);
});

final productNotifierProvider =
    AsyncNotifierProvider<ProductNotifier, List<Product>>(
      () => ProductNotifier(locator.get<ProductRepository>()),
    );

class ProductNotifier extends AsyncNotifier<List<Product>> {
  final ProductRepository _productRepository;

  ProductNotifier(this._productRepository);

  @override
  FutureOr<List<Product>> build() async {
    log('ProductNotifier: Starting build()');
    final products = await _productRepository.getProducts();
    log('ProductNotifier: Received ${products.length} products');
    log('ProductNotifier: Product IDs: ${products.map((p) => p.id).toList()}');
    return products;
  }

  Future<void> refreshProducts() async {
    log('ProductNotifier: Starting refreshProducts()');
    state = const AsyncLoading();
    try {
      final products = await _productRepository.getProducts();
      log('ProductNotifier: Refreshed with ${products.length} products');
      log(
        'ProductNotifier: Refreshed Product IDs: ${products.map((p) => p.id).toList()}',
      );
      state = AsyncData(products);
    } catch (e, stack) {
      log(
        'ProductNotifier: Error refreshing products',
        error: e,
        stackTrace: stack,
      );
      state = AsyncError(e, stack);
    }
  }
}
