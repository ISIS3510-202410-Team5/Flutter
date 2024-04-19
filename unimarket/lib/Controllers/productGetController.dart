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

  static List<ProductModel> products_list = [
    ProductModel(0, "Libro Anadec", "Book", 67000, "New product",
        "https://image.cdn0.buscalibre.com/2992268.__RS360x360__.jpg", 0),
    ProductModel(
        1,
        "Libro Anadec",
        "Book",
        50000,
        "Used product",
        "https://th.bing.com/th/id/OIP.22Gl4tn8EHYC4YiYjSF5tQAAAA?rs=1&pid=ImgDetMain",
        0),
    ProductModel(2, "Libro Fisica 2", "Book", 80000, "New product",
        "https://www.etp.com.py/img/tapa-mediana-8955.jpg", 0),
    ProductModel(
        3,
        "Libro Fisica 2",
        "Book",
        70000,
        "Used product",
        "https://th.bing.com/th/id/OIP.l3XVMN3H6pOOTM5GNg1o0gAAAA?rs=1&pid=ImgDetMain",
        0),
    ProductModel(
        4,
        "Libro Fisica 2",
        "Book",
        75000,
        "New product",
        "https://http2.mlstatic.com/D_NQ_NP_674359-MLC47188618536_082021-O.jpg",
        0),
    ProductModel(
        5,
        "Calculadora Científica Casio",
        "School",
        140000,
        "Used product",
        "https://http2.mlstatic.com/calculadora-cientifica-casio-fx-82ms-D_NQ_NP_622288-MLM40187065116_122019-F.jpg",
        0),
    ProductModel(
        6,
        "Calculadora Científica Casio",
        "School",
        120000,
        "Used product",
        "https://http2.mlstatic.com/cientifica-casio-calculadora-D_NQ_NP_307515-MLB25257392781_012017-F.jpg",
        0),
    ProductModel(
        7,
        "Calculadora Científica Casio",
        "School",
        130000,
        "Used product",
        "https://www.papeleriaomega.com.mx/imagenessia/018001.jpg",
        0),
    ProductModel(
        8,
        "Compas",
        "School",
        10000,
        "New product",
        "https://th.bing.com/th/id/R.71214ae37a4834b34a14b1fc4a1d75b3?rik=3qp33D35d%2bFPWg&riu=http%3a%2f%2fmedia.ldlc.com%2fld%2fproducts%2f00%2f03%2f92%2f94%2fLD0003929483_2.jpg&ehk=V3khYkkar5yQJB6m88Iv0fAD4hnTtfHueKo7TAXJnSo%3d&risl=&pid=ImgRaw&r=0",
        0),
    ProductModel(
        9,
        "Compas",
        "School",
        7000,
        "New product",
        "https://image.ceneostatic.pl/data/products/37909381/f-kamet-cyrkiel-szkolny-kamet.jpg",
        0),
  ];
  Future<DocumentReference<Map<String, dynamic>>> addProductToCatalog() {
    return FirebaseFirestore.instance.collection('products').add({
      'name': "Libro Anadec",
      'price': 50000,
      'category': "Book",
      'image':
          "https://th.bing.com/th/id/OIP.22Gl4tn8EHYC4YiYjSF5tQAAAA?rs=1&pid=ImgDetMain",
      'used': true,
      'description': "libro anadec perfectas condiciones",
      //'sellerId': FirebaseAuth.instance.currentUser!.uid,
      'sold': false,
      'views': 0,
      // 1,
      //   "Libro Anadec",
      //   "Book",
      //   50000,
      //   "Used product",
      //   "https://th.bing.com/th/id/OIP.22Gl4tn8EHYC4YiYjSF5tQAAAA?rs=1&pid=ImgDetMain",
      //   0)
    });
  }
}
