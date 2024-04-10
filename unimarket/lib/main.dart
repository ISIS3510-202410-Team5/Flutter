import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unimarket/Views/body_view.dart';
import 'package:unimarket/Views/vista_login.dart';
import 'package:unimarket/firebase_options.dart';
import 'package:unimarket/Views/vista_login.dart';
import 'package:unimarket/Views/vista_registrarse.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'unimarket-app',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniMarket',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: VistaLogin(),
    );
  }
}
