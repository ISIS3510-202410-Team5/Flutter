import 'package:cloud_firestore/cloud_firestore.dart';

class Producto {
  final String coverUrl;
  final String? id;
  final String latitud;
  final String longitud;
  final String precio;
  final String title;

  const Producto(
      {required this.coverUrl,
      this.id,
      required this.latitud,
      required this.longitud,
      required this.precio,
      required this.title});
  toJson() {
    return {
      "coverUrl": coverUrl,
      "id": id,
      "latitud": latitud,
      "longitud": longitud,
      "precio": precio,
      "title": title
    };
  }

  factory Producto.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Producto(
        coverUrl: data["coverUrl"],
        id: document.id,
        latitud: data["latitud"],
        longitud: data["longitud"],
        precio: data["precio"],
        title: data["title"]);
  }
}