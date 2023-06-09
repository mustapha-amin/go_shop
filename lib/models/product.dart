class Product {
  String? imgPath;
  String? name;
  double? price;
  String? description;

  Product({this.imgPath, this.name, this.price, this.description});

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      imgPath: json['imgPath'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
    );
  }
}
