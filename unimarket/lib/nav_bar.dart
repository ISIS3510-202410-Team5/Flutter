// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key, required this.selectedIndex, required this.onDestinationSelected});
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      height: 60,
      onDestinationSelected: onDestinationSelected,
      backgroundColor: Colors.deepOrange[300],
      shadowColor: Colors.deepOrange,
      
      
      // ignore: prefer_const_literals_to_create_immutables
      destinations: [
        
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home'
        ),
      
        NavigationDestination(
          icon: Icon(Icons.search_outlined),
          selectedIcon: Icon(Icons.search),
          label: 'Search',
        ),

        NavigationDestination(
          icon: Icon(Icons.shopping_cart_outlined),
          selectedIcon: Icon(Icons.shopping_cart),
          label: 'MyCart'
        ),

        NavigationDestination(
          icon: Icon(Icons.add_circle_outline_outlined, size:65),
          selectedIcon: Icon(Icons.add_circle_outline_rounded, size:65),
          label: '',
          
        ),

        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: 'Settings'
        ),

        NavigationDestination(
          icon: Icon(Icons.chat_outlined),
          selectedIcon: Icon(Icons.chat),
          label: 'Chat'
        ),

        NavigationDestination(
          icon: Icon(Icons.person_outlined),
          selectedIcon: Icon(Icons.person),
          label: 'Profile'
        ),
    ]);
  }
}