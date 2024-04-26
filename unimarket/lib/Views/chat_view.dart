import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:unimarket/Controllers/cart_controller.dart';

import 'package:unimarket/Controllers/search_controllerUnimarket.dart';
import 'package:unimarket/Models/Repository/cartRepository.dart';
import 'package:unimarket/Models/Repository/productReposirory.dart';
import 'package:unimarket/Models/model.dart';

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
            print(CartController().getCartProducts().toString());
          },
          child: Text('Press Me'),
        ),
      ),
    );
  }
}
