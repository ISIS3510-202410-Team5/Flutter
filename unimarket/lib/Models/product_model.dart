class ProductModel {
  String? id;
  String name;
  String category;
  int price;
  bool used;
  String image;
  bool sold;
  int views = 0;
  String description;

  ProductModel(
    this.id,
    this.name,
    this.category,
    this.price,
    this.used,
    this.image,
    this.sold,
    this.views,
    this.description,
  );
  // toJson() {
  //   return {
  //     "id": id,
  //     "name": name,
  //     "category": category,
  //     "price": price,
  //     "used": used,
  //     "image": image,
  //     "sold": sold,
  //     "views = 0": views,
  //   };
  // }

  // factory ProductModel.fromSnapshot(
  //     DocumentSnapshot<Map<String, dynamic>> document) {
  //   final data = document.data()!;
  //   return ProductModel(
  //       id: document.id,
  //       name: data["name"],
  //       category: data["category"],
  //       price: data["price"],
  //       used: data["used"],
  //       image: data["image"],
  //       sold: data["sold"],
  //       views: data["views"]);
  // }
}
