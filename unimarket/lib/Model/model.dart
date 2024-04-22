import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unimarket/Model/Repository/productReposirory.dart';
import 'package:unimarket/Model/product_model.dart';

class Model {
  final productos = <ProductModel>[];

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
}
