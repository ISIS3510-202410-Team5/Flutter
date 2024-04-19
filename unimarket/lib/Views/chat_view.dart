import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:unimarket/Controllers/productGetController.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  Uint8List? image;
  late ProductGetController control;
  static  control = ProductGetController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Button Example'),
        ),
        body: ElevatedButton(
          onPressed: () => control.addProductToCatalog(),
          child: Text('Press Me'),
        ));
  }
}
