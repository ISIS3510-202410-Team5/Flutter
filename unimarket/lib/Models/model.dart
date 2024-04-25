import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unimarket/Models/Repository/productReposirory.dart';
import 'package:unimarket/Models/product_model.dart';

class Model {
  final productos = <ProductModel>[];
  var userId;

  static final Model single = Model._();
  factory Model() => single;
  Model._();

  getProducts() {
    return productos;
  }

  addProduct(ProductModel p) {
    productos.add(p);
  }

  cargarProductos() {
    ProductRepository().getData();
  }

  setUserId(String? uid) {
    userId = uid;
  }

  getUserId() {
    return userId;
  }
}
