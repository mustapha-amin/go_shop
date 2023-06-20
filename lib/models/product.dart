class Product {
  String? imgPath;
  String? name;
  double? price;
  String? description;
  String? category;

  Product({this.imgPath, this.name, this.price, this.description, this.category});

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      imgPath: json['imgPath'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      category: json['category'],
    );
  }
}
