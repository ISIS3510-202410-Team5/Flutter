import 'package:flutter/material.dart';
import 'package:unimarket/Models/Repository/cartRepository.dart';
import 'package:unimarket/Models/model.dart';
import 'package:unimarket/Models/product_model.dart';

class CartController extends ChangeNotifier {
  List<ProductModel> getCartProducts() {
    return Model().getCartProducts();
  }
}
