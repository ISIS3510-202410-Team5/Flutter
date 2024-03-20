import 'dart:ui';

import 'package:flutter/material.dart';

/// Flutter code sample for [SearchBar].

void main() => runApp(const SearchView1());

class SearchView1 extends StatefulWidget {
  const SearchView1({super.key});

  @override
  State<SearchView1> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchView1> {
  
  bool isDark = false;

  @override
  Widget build(BuildContext context) {

    final ThemeData themeData = ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
    );

    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('New Search', style: TextStyle(
            color: Colors.black,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          )),
          backgroundColor: Colors.white,
          elevation: 0.2,
        ),

        body: Padding(
          padding: const EdgeInsets.all(8),
          child: SearchAnchor(

            builder: (BuildContext context, SearchController controller) {
            
            return SearchBar(
              controller: controller,
              padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0)
              ),

              onTap: () {
                controller.openView();
              },

              onChanged: (_) {
                controller.openView();
              },

              leading: const Icon(Icons.search),

              trailing: <Widget>[
                Tooltip(
                  message: 'Change brightness mode',
                  child: IconButton(
                    isSelected: isDark,
                    onPressed: () {
                      setState(() {
                        isDark = !isDark;
                      });
                    },
                    icon: const Icon(Icons.wb_sunny_outlined),
                    selectedIcon: const Icon(Icons.brightness_2_outlined),
                  ),
                )
              ],
            );
          }, suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
            return List<ListTile>.generate(5, (int index) {
              final String item = 'item $index';
              return ListTile(
                title: Text(item),
                onTap: () {
                  setState(() {
                    controller.closeView(item);
                  });
                },
              );
            });
          }),
        ),
      ),
    );
  }
}