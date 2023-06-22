import 'package:go_shop/models/product.dart';

class FeaturedProduct {
  Product? product;
  String? message;

  FeaturedProduct({this.product, this.message});

  factory FeaturedProduct.fromJson(Map<String, dynamic> json) {
    return FeaturedProduct(
      product:
          json['product'] != null ? Product.fromJson(json['product']) : null,
      message: json['message'],
    );
  }
}
