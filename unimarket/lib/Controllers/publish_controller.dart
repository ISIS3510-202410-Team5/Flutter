import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unimarket/Model/product_model.dart';
import 'package:unimarket/Model/seller_model.dart';

class PublishController extends ChangeNotifier{

  double value = 0.0;

  final TextEditingController iconController  = TextEditingController();
  final TextEditingController useController  = TextEditingController();

  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerPrice = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();
  
  void setValue(double value){
    this.value = value;
  }

  Future addProductToCatalog(ProductModel product) {

    return FirebaseFirestore.instance.collection('products').add({
      'name': product.product_name,
      'price': product.product_price,
      'category': product.product_category,
      'image': product.product_image,
      'used': product.product_use,
      'description': product.product_description,
      //'sellerId': FirebaseAuth.instance.currentUser!.uid,
      'sold': false,
      'views': 0,
    });
  }
}