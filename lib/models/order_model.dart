import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  String? productID;
  String? customerID;
  String? orderID;
  int? quantity;
  double? price;
  String? state;
  String? LGA;
  String? address;
  DateTime? orderDate;

  Order({
    this.productID,
    this.orderID,
    this.customerID,
    this.quantity,
    this.price,
    this.state,
    this.LGA,
    this.address,
    this.orderDate,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      productID: json['productID'],
      customerID: json['customerID'],
      orderID: json['orderID'],
      quantity: json['quantity'],
      price: json['price'],
      state: json['state'],
      LGA: json['LGA'],
      address: json['address'],
      orderDate: (json["orderDate"] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productID': productID,
      'customerID': customerID,
      'orderID': orderID,
      'quantity': quantity,
      'price': price,
      'state': state,
      'LGA': LGA,
      'address': address,
      'orderDate': orderDate,
    };
  }
}
