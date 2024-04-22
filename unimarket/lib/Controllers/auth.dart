import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

//iniciari sesión con email y contraseña
  Future ingresar(String email, String password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? usuario = result.user;
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
