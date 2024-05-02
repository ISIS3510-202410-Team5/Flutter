import 'package:flutter/material.dart';
import 'package:unimarket/Models/model.dart';

class SearchControllerUnimarket extends ChangeNotifier {

  final TextEditingController iconController = TextEditingController();
  final TextEditingController useController = TextEditingController();

  final TextEditingController searchBarController = TextEditingController();

  getProducts() {
    return Model().getProducts();
  }

  getAllProducts(){
    return Model().getAllProducts();
  }

  getFilteredProducts(String category, bool use){
    return Model().getFilteredProducts(category, use);
  }

  cargarProductos() {
    Model().cargarProductos();
  }
}
