import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unimarket/Models/productos.dart';

class HomeController extends ChangeNotifier{

  Future<List<Producto>> productos() async {
    final snapshot = await FirebaseFirestore.instance.collection("productos").get();

    final prods = snapshot.docs.map((e) => Producto.fromSnapshot(e)).toList();
    return prods;
  }
}