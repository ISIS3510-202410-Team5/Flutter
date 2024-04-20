import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unimarket/Views/body_view.dart';
import 'package:unimarket/Views/home_view.dart';
import 'package:unimarket/Views/publish_view.dart';
import 'package:unimarket/Views/login_view.dart';
import 'package:unimarket/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'unimarket',
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
        
      ),
      home: const LoginView(),
      //home: HomeView(),
      //home: PublishView(),
    );
  }
}
