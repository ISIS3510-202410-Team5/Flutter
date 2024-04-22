import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unimarket/Model/model.dart';
import 'package:unimarket/Model/product_model.dart';
import 'package:unimarket/Model/seller_model.dart';

class Controller {
  getProducts() {
    return Model().getProducts();
  }

  cargarProductos() {
    Model().cargarProductos();
  }
}
