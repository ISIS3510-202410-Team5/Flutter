import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:unimarket/Controllers/search_controllerUnimarket.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  Uint8List? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Add your button onPressed logic here
            //print(Controller().cargarProductos().toString());
            // SearchController().getProducts();
          },
          child: Text('Press Me'),
        ),
      ),
    );
  }
}
