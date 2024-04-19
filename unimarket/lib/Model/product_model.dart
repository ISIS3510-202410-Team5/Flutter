import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? id;
  String name;
  String category;
  int price;
  bool used;
  String image;
  bool sold;
  int views = 0;

  ProductModel({
    this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.used,
    required this.image,
    required this.sold,
    required this.views,
  });
  toJson() {
    return {
      "id": id,
      "name": name,
      "category": category,
      "price": price,
      "used": used,
      "image": image,
      "sold": sold,
      "views = 0": views,
    };
  }

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ProductModel(
        id: document.id,
        name: data["name"],
        category: data["category"],
        price: data["price"],
        used: data["used"],
        image: data["image"],
        sold: data["sold"],
        views: data["views"]);
  }
}
