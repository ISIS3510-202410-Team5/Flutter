import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unimarket/Models/Repository/productReposirory.dart';
import 'package:unimarket/Models/product_model.dart';

class Model {
  final productos = <ProductModel>[];
  List<ProductModel> filteredProducts = <ProductModel>[];
  var userId;

  static final Model single = Model._();
  factory Model() => single;
  Model._();

  List<ProductModel> createList(){
    List<ProductModel> lista = <ProductModel>[];
    return lista;
  }

  getProducts() {
    cargarProductos();
    return productos;
  }

  getFilteredProducts(String category, bool use) async {
    List<ProductModel> lista = <ProductModel>[];
    await ProductRepository().getFilteredProducts(category, use, lista);
    return lista;
  }

  addProduct(ProductModel p) {
    productos.add(p);
  }

  addFilteredProduct(ProductModel product, List<ProductModel> lista){
    lista.add(product);
    //filteredProducts.add(product);
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
