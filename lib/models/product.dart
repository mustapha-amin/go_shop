import 'package:uuid/uuid.dart';

class Product {
  String id;
  String? imgPath;
  String? name;
  int? price;
  String? description;
  bool discounted;

  Product({this.imgPath, this.name, this.price, this.description, this.discounted = false}) : id = Uuid().v4();

 
}
