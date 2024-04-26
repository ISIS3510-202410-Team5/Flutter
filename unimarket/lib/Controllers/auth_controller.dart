import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unimarket/Controllers/cart_controller.dart';
import 'package:unimarket/Controllers/search_controllerUnimarket.dart';
import 'package:unimarket/Models/Repository/cartRepository.dart';
import 'package:unimarket/Models/model.dart';
import 'package:unimarket/Models/user_model.dart';

class AuthController {
  final FirebaseAuth auth = FirebaseAuth.instance;

//iniciari sesión con email y contraseña
  Future ingresar(String email, String password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? usuario = result.user;
      String? uuid = usuario?.uid.toString();
      SearchControllerUnimarket().cargarProductos();
      Model().setUserId(uuid);

      CartRepository().createCart();
      CartRepository().getCart(Model().userId);
      return true;
    } catch (error) {
      print(error.toString());
      return false;
    }
  }

  ////registrar email y contraseña
  Future registrar(String email, String contrasena) async {
    try {
      UserCredential resultado = await auth.createUserWithEmailAndPassword(
          email: email, password: contrasena);
      User? usuario = resultado.user;
      return usuario;
      // print("Tipo UserCredential  " + resultado.toString());
      // print("Tipo User  " + usuario.toString());
    } catch (e) {
      print(e.toString());
      // rethrow;
    }
  }
}
