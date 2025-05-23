import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop/features/bottom_nav/repository/product_repository.dart';
import 'package:go_shop/models/product.dart';
import 'package:go_shop/services/dependencies.dart';

final getProductByIDProvider = FutureProvider.family<Product, String>((ref, id) async {
  return locator.get<ProductRepository>().getProductById(id);
});

final productNotifierProvider = AsyncNotifierProvider<ProductNotifier, List<Product>>(
  ()=> ProductNotifier(
    locator.get<ProductRepository>()
  )
);

class ProductNotifier extends AsyncNotifier<List<Product>> {
  final ProductRepository _productRepository;

  ProductNotifier(this._productRepository);

  @override
  FutureOr<List<Product>> build() {
    return _productRepository.getProducts();
  }

  Future<void> refreshProducts() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _productRepository.getProducts());
  }
}