import 'package:unimarket/Models/Repository/cartRepository.dart';
import 'package:unimarket/Models/Repository/productReposirory.dart';
import 'package:unimarket/Models/product_model.dart';

class Model {
  final productos = <ProductModel>[];
  final productosCarrito = <ProductModel>[];
  var userId;
  var cartPrice = 0;

  static final Model single = Model._();
  factory Model() => single;
  Model._();

  List<ProductModel> getProducts() {
    return productos;
  }

  List<ProductModel> getCartProducts() {
    return productosCarrito;
  }

  getProductById(String id, String from) {
    if (from == "Products") {
      ProductModel find() =>
          productos.firstWhere((product) => product.id == id);
      return find();
    } else if (from == "Cart") {
      ProductModel find() =>
          productosCarrito.firstWhere((product) => product.id == id);
      return find();
    }

    return -1;
  }

  void addProduct(ProductModel p) {
    productos.add(p);
  }

  getFilteredProducts(String category, bool use) async {
    List<ProductModel> lista = <ProductModel>[];
    await ProductRepository().getFilteredProducts(category, use, lista);
    return lista;
  }

  addFilteredProduct(ProductModel product, List<ProductModel> lista) {
    lista.add(product);
    //filteredProducts.add(product);
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
    ProductModel producto = getProductById(idProducto, "Products");
    if (!productosCarrito.contains(producto)) {
      productosCarrito.add(producto);
      cartPrice += producto.price;
    }
  }

  meterProductoCarritoInicio(String idProducto) {
    ProductModel producto = getProductById(idProducto, "Products");
    productosCarrito.add(producto);
    cartPrice = cartPrice + producto.price;
  }
}
