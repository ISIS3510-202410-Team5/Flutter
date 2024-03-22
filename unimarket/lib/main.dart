import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unimarket/firebase_options.dart';
import 'package:unimarket/vistas/vista_home.dart';
import 'package:unimarket/vistas/vista_login.dart';

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
