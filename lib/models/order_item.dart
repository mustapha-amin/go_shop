class OrderItem {
  final String productID;
  final int quantity;
  final double price; 

  OrderItem({
    required this.productID,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'productID': productID,
      'quantity': quantity,
      'price': price,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      productID: map['productID'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
