import 'package:flutter/material.dart';
import 'package:unimarket/nav_bar.dart';
import 'package:unimarket/search.dart';

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
      child: Text('Here goes the home page'),
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
      child: Text('Here goes the buying page'),
    ),

    Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Text('Here goes the settings page'),
    ),

    Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Text('Here goes the chat page'),
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
}