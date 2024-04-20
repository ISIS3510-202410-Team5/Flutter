import 'package:flutter/material.dart';
import 'package:unimarket/Models/product_model.dart';
import 'package:unimarket/Views/productDetail_view.dart';

class ProductDetail{

  late ProductModel product;
  late StatelessWidget view;

  ProductDetail(ProductModel prod){
    product = prod;
    view = ProductDetailView(product);
  }
}