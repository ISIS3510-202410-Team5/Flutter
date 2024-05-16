import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unimarket/Views/home_view.dart';
import 'package:unimarket/Views/publish_view/publish_view.dart';
import 'package:unimarket/Views/search_view/search_view.dart';
import 'package:unimarket/firebase_options.dart';
import 'package:unimarket/Views/login_view.dart';
import 'package:unimarket/resources/connectivity_service.dart';
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
    return MultiProvider(
      providers: [
        StreamProvider(
          create: (context)=> ConnectivityService().controller.stream, 
          initialData: NetworkStatus.online
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeNotifier()
        ),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            title: 'UniMarket',
            theme: notifier.darkTheme ? dark : light,
            debugShowCheckedModeBanner: false,
            
            //home: const LoginView(),
            //home: const HomeView(),
            home: const PublishView(),
            //home: SearchView(categoryIndex: 5,),
          );
        },
      ),
    );
  }
}
