import 'package:flutter/material.dart';
import 'package:unimarket/Models/Repository/cartRepository.dart';
import 'package:unimarket/Models/Repository/productReposirory.dart';

class ProductDetailController extends ChangeNotifier {
  void addProductToCart(String? pId) {
    CartRepository().addToCart(pId);
  }
}
