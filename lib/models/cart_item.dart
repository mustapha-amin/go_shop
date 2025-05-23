// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartItem {
  String? id;
  String? productID;
  int? quantity;

  CartItem({this.productID, this.quantity, this.id});

  CartItem.fromJson(Map<String, dynamic> json) {
    productID = json['productID'];
    quantity = json['quantity'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productID'] = productID;
    data['quantity'] = quantity;
    data['id'] = id;
    return data;
  }

  @override
  String toString() => 'CartItem(productID: $productID, quantity: $quantity, id: $id)';

  @override
  bool operator ==(covariant CartItem other) {
    if (identical(this, other)) return true;

    return other.productID == productID && other.quantity == quantity && other.id == id;
  }

  @override
  int get hashCode => productID.hashCode ^ quantity.hashCode ^ id.hashCode;
}
