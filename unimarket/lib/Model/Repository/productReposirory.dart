import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unimarket/Model/model.dart';
import 'package:unimarket/Model/product_model.dart';
import 'package:unimarket/Model/seller_model.dart';
import 'package:uuid/uuid.dart';

class ProductRepository {
  final _DB = FirebaseFirestore.instance;
  int numProds = 0;

  // Future<List<ProductModel>> cargarProductos() async {
  //   final snapshot = await _DB.collection("products").get();
  //   print(snapshot.docs.toString());
  //   final prods =
  //       snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();

  //   return prods;
  // }

  // List<ProductModel> getProductos() {
  //   cargarProductos().then((p) => productos = p);
  //   return productos;
  // }

  void getData() async {
    await FirebaseFirestore.instance.collection("products").get().then((value) {
      for (var i in value.docs) {
        ProductModel producto = ProductModel(
            i.id,
            i.data()["name"],
            i.data()["category"],
            i.data()["price"],
            i.data()["used"],
            i.data()["image"],
            i.data()["sold"],
            i.data()["views"]);
        Model().addProduct(producto);
      }
    });
  }
}
