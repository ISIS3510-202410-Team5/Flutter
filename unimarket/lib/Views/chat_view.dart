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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Under Construction'),
      ),
      body: Center(
        child: Text(
          'This area is under construction.',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
