class Category {
  String? name;
  String? imgPath;

  Category({this.name, this.imgPath});

  static Category fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      imgPath: json['imgPath'],
    );
  }
}
