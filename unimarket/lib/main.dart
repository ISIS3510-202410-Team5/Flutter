import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unimarket/Views/body_view.dart';
import 'package:unimarket/Views/home_view.dart';
import 'package:unimarket/Views/publish_view.dart';
import 'package:unimarket/Views/login_view.dart';
import 'package:unimarket/firebase_options.dart';
import 'package:unimarket/Views/login_view.dart';
import 'package:unimarket/Views/register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unimarket/theme.dart';

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
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            title: 'UniMarket',
            theme: notifier.darkTheme ? dark : light,
            home: const BodyView(),
            //home: const HomeView(),
            // home: const PublishView(),
          );
        },
      ),
    );
  }
}
