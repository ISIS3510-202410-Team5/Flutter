import 'package:flutter/material.dart';
import 'package:unimarket/vistas/vista_home.dart';
import 'package:unimarket/vistas/vista_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniMarket',
      theme: ThemeData(),
      home: const VistaLogin(),
      routes: {
        'VistaHome': (context) => const VistaHome(),
        'VistaLogin': (context) => const VistaLogin(),
      },
    );
  }
}
