import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:unimarket/Views/chat_view.dart';
import 'package:unimarket/Views/home_view.dart';
import 'package:unimarket/Views/publish_view.dart';
import 'package:unimarket/Views/search_view.dart';
import 'package:unimarket/nav_bar.dart';

class BodyView extends StatefulWidget {
  const BodyView({super.key});

  @override
  State<BodyView> createState() => _BodyViewState();
}

class _BodyViewState extends State<BodyView> {
  int currentIndex = 0;

  var pageViewList = [
    Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: const HomeView(),
    ),
    Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: const SearchView(),
    ),
    Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Text('Here goes my cart page'),
    ),
    Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: const PublishView(),
    ),
    Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Text('Here goes the settings page'),
    ),
    Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: const ChatView(),
    ),
    Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Text('Here goes the user profile page'),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(
        onDestinationSelected: (int value) {
          setState(() {
            currentIndex = value;
          });
        },
        selectedIndex: currentIndex,
      ),
      body: pageViewList[currentIndex],
    );
  }

  late ShakeDetector detector;

  @override
  void initState() {
    detector = ShakeDetector.autoStart(onPhoneShake: () {
      setState(() {
        currentIndex = 3;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    detector.stopListening();
    super.dispose();
  }
}
