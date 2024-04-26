import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unimarket/Models/Repository/cartRepository.dart';
import 'package:unimarket/Models/Repository/productReposirory.dart';
import 'package:unimarket/Models/product_model.dart';

class Model {
  final productos = <ProductModel>[];
  final productosCarrito = <ProductModel>[];
  var userId;

  static final Model single = Model._();
  factory Model() => single;
  Model._();

  List<ProductModel> getProducts() {
    return productos;
  }

  List<ProductModel> getCartProducts() {
    return productosCarrito;
  }

  ProductModel? getProductById(String id, String from) {
    if (from == "Products") {
      ProductModel find() =>
          productos.firstWhere((product) => product.id == id);
      return find();
    } else if (from == "Cart") {
      ProductModel find() =>
          productosCarrito.firstWhere((product) => product.id == id);

      return find();
    }

    return null;
  }

  void addProduct(ProductModel p) {
    productos.add(p);
  }

  void addProductToCart(String? pId) {
    CartRepository().addToCart(pId);
  }

  void cargarProductos() {
    ProductRepository().getData();
  }

  void loadCart() {
    CartRepository().getCart(userId);
  }

  void setUserId(String? uid) {
    userId = uid;
  }

  String getUserId() {
    return userId;
  }

  meterProductoCarrito(String idProducto) {
    if (getProductById(idProducto, "Products") != null &&
        getProductById(idProducto, "Cart") == null) {
      productosCarrito.add(getProductById(idProducto, "Products"));
    }
  }
}
