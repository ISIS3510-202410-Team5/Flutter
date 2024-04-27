import 'package:flutter/material.dart';
import 'package:unimarket/Models/Repository/cartRepository.dart';
import 'package:unimarket/Models/Repository/productReposirory.dart';
import 'package:unimarket/Models/model.dart';

class ProductDetailController extends ChangeNotifier {
  void addProductToCart(String? pId) {
    Model().addProductToCart(pId);
    Model().loadCart();
  }
}
