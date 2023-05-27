import 'models/product.dart';

class GlobalProducts {
  static String basePath = 'assets/images/offers';
  static String? text =
      "The framework can call this method multiple times over the lifetime of a [StatefulWidget]. For example, if the widget is inserted into the tree in multiple locations, the framework will create a separate [State] object for each location";
  static List<Product> products = [
    Product(
      name: "Nike air",
      imgPath: '$basePath/shoe.png',
      discounted: true,
      description: text,
      price: 80000,
    ),
    Product(
      name: "T-shirt",
      imgPath: '$basePath/shirt.png',
      discounted: true,
      description: text,
      price: 75000,
    ),
    Product(
      name: "HP laptop",
      imgPath: '$basePath/laptop.png',
      discounted: true,
      description: text,
      price: 90000,
    ),
    Product(
      name: "Nike air",
      imgPath: '$basePath/shoe.png',
      discounted: true,
      description: text,
      price: 80000,
    ),
    Product(
      name: "T-shirt",
      imgPath: '$basePath/shirt.png',
      discounted: true,
      description: text,
      price: 75000,
    ),
    Product(
      name: "HP laptop",
      imgPath: '$basePath/laptop.png',
      discounted: true,
      description: text,
      price: 90000,
    ),
  ];
}
