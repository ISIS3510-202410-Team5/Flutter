import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unimarket/modelo/usuario.dart';
import 'dart:developer' as dev;

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

// crear usuario a partir del firebaseuser
  Usuario? usuarioFireBase(User user) {
    // ignore: unnecessary_null_comparison
    return user != null ? Usuario(usuarioId: user.uid) : null;
  }

//iniciari sesión con email y contraseña
  Future ingresar(String email, String password) async {
    if (!isValidEmail(email)) {
      return false;
    }
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

  bool isValidEmail(String email) {
    // Regular expression for validating an email address
    final RegExp emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      caseSensitive: false,
      multiLine: false,
    );

    return emailRegex.hasMatch(email);
  }

  ////registrar email y contraseña
  Future registrar(String email, String contrasena) async {
    try {
      UserCredential resultado = await auth.createUserWithEmailAndPassword(
          email: email, password: contrasena);
      User? usuario = resultado.user;
      print("Tipo UserCredential  " + resultado.toString());
      print("Tipo User  " + usuario.toString());
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
