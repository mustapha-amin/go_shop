// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final String id;
  final String name;
  final String description;
  final String category;
  final String brand;
  final double basePrice;
  final int quantity;
  final double discountPercentage;
  final List<String> imageUrls;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.brand,
    required this.basePrice,
    required this.quantity,
    required this.discountPercentage,
    required this.imageUrls,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      brand: map['brand'] as String,
      basePrice: (map['basePrice'] as num).toDouble(),
      quantity: map['quantity'] as int,
      discountPercentage: (map['discountPercentage'] as num).toDouble(),
      imageUrls: List<String>.from(map['imageUrls']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'brand': brand,
      'basePrice': basePrice,
      'quantity': quantity,
      'discountPercentage': discountPercentage,
      'imageUrls': imageUrls,
    };
  }

  Product copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    String? brand,
    double? basePrice,
    int? quantity,
    double? discountPercentage,
    List<String>? imageUrls,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      basePrice: basePrice ?? this.basePrice,
      quantity: quantity ?? this.quantity,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }
}

final dummyProduct = Product(
  id: '27285052-8fc0-4a62-833b-486a1d66636f',
  name: 'Samsung galaxy S24',
  description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus interdum, libero non sagittis vestibulum, lacus lorem aliquet urna, sit amet facilisis orci odio in leo. Aliquam erat volutpat. Curabitur efficitur, arcu in sollicitudin gravida, nunc erat vehicula nibh, ut elementum neque odio non justo. Suspendisse potenti.  Proin a erat vel lorem facilisis dictum. Nullam venenatis, leo nec condimentum pharetra, eros arcu vulputate nunc, vel auctor velit metus ut metus. Phasellus interdum dui id libero porta, nec egestas turpis convallis. Integer at mi a purus tristique placerat.  Nunc porttitor vehicula nulla, vel fermentum eros. Fusce posuere sem et elit fermentum, at efficitur metus ultrices. Duis vulputate congue tortor, in cursus lectus suscipit id. Ut lacinia fringilla lectus, sed suscipit elit pellentesque id. Sed eget lacinia mi, ut consectetur nunc.',
  category: 'Phones and tablets',
  brand: 'Samsung',
  basePrice: 600000,
  quantity: 12,
  discountPercentage: 0,
  imageUrls: [
    'https://firebasestorage.googleapis.com/v0/b/go-shop-3d5ba.appspot.com/o/products%2F27285052-8fc0-4a62-833b-486a1d66636f%2Fimage_0.jpg?alt=media&token=cd634b98-b7aa-434e-8a9c-05aef3d7e2f8',
  ],
);
