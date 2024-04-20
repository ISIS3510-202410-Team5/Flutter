
// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

class ProductModel{

  //int? product_id;
  String? product_name;
  String? product_category;
  int? product_price;
  String? product_use;
  String? product_image;
  String? product_description;
  int product_views = 0;

  ProductModel(
    this.product_name, 
    this.product_category, 
    this.product_price, 
    this.product_use, 
    this.product_image, 
    this.product_description, 
    this.product_views
  );
}