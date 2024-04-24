import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unimarket/Models/model.dart';
import 'package:unimarket/Models/product_model.dart';
import 'package:unimarket/Models/seller_model.dart';

class SearchControllerUnimarket {
  getProducts() {
    return Model().getProducts();
  }

  cargarProductos() {
    Model().cargarProductos();
  }
}
