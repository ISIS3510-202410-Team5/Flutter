import 'dart:typed_data';

import 'package:flutter/material.dart';

class PublishView extends StatefulWidget {
  const PublishView({super.key});

  @override
  State<PublishView> createState() => _PublishViewState();
}

class _PublishViewState extends State<PublishView> {
  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Column(
            children: [
              Text("Publish a New Product", style: TextStyle(color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.bold)),
              Divider(height: 5, thickness:3, indent: 50, endIndent: 50, color: Colors.deepOrange,),
              
            ],
      ),),
      body: Center(
        child: Stack(
          children: [
            image != null?
            CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage("https://cdn4.iconfinder.com/data/icons/documents-36/25/add-picture-512.png")
            ,) :
            CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage("https://cdn4.iconfinder.com/data/icons/documents-36/25/add-picture-512.png")
            ,),
            Positioned(
              bottom:-10,
              left: 140,
              child: IconButton(onPressed: (){showImagePickerOption(context);}, icon: Icon(Icons.add_a_photo))
            )
          ],
        ),
      )
    );
  }

  void showImagePickerOption(BuildContext context){
    showModalBottomSheet(backgroundColor: Colors.deepOrange[200], context: context, builder: (builder){
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: (){},
                child: SizedBox(
                  child: Column(
                    children: [
                      Icon(Icons.image),
                      Text("Gallery"),
                    ]
                  ),
                )
              ),
            ),

            Expanded(
              child: InkWell(
                onTap: (){},
                child: SizedBox(
                  child: Column(
                    children: [
                      Icon(Icons.camera),
                      Text("Camera"),
                    ]
                  ),
                )
              ),
            ),
          ],
        ),
      );
    });
  }
}