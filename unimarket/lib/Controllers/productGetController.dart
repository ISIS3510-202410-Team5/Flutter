import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unimarket/Model/product_model.dart';
import 'package:unimarket/Model/seller_model.dart';

class ProductGetController extends ChangeNotifier {
  double value = 0.0;

  void setValue(double value) {
    this.value = value;
  }
}
