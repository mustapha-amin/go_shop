class Product {
  String? id;
  String? imgPath;
  String? name;
  double? price;
  String? description;
  String? category;

  Product(
      {this.id,
      this.imgPath,
      this.name,
      this.price,
      this.description,
      this.category});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      imgPath: json['imgPath'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imgPath': imgPath,
      'name': name,
      'price': price,
      'description': description,
      'category': category,
    };
  }
}
