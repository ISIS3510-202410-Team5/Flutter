import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:unimarket/Controllers/publish_controller.dart';
import 'package:unimarket/Models/product_model.dart';
import 'package:unimarket/theme.dart';

enum ColorLabel {
  newProduct('Never used', Colors.black, Colors.yellow),
  oldProduct('Second-hand', Colors.black, Colors.grey);

  const ColorLabel(this.label, this.color, this.colorIcon);
  final String label;
  final Color color;
  final Color colorIcon;
}

enum IconLabel {
  paint('Art Materials', Icons.format_paint),
  audiovisuals('Audiovisuals', Icons.camera_rounded),
  security('Security', Icons.security_rounded),
  books('Books', Icons.book),
  hardware('Hardware', Icons.computer_rounded);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}

class PublishView extends StatefulWidget {
  const PublishView({super.key});

  @override
  State<PublishView> createState() => _PublishViewState();
}

class _PublishViewState extends State<PublishView> {
  //For the images manipulation
  Uint8List? _image;
  File? selectedImage;

  //For the category definition
  ColorLabel? selectedColor;
  Color colorIcon = Colors.deepOrange;
  IconData iconCategory = Icons.question_mark;
  IconLabel? selectedIcon;

  //For the controller
  late PublishController _publishController;

  @override
  void initState() {
    _publishController = PublishController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Column(
            children: [
              Text("Publish a New Product",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold)),
              Divider(
                height: 5,
                thickness: 3,
                indent: 50,
                endIndent: 50,
                color: Colors.deepOrange,
              ),
            ],
          ),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Card(
                color: Provider.of<ThemeNotifier>(context).getTheme().cardColor,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Column(children: [
                            const Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Product Image",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            const Divider(
                              height: 5,
                              thickness: 1.7,
                              indent: 10,
                              endIndent: 155,
                              color: Colors.deepOrange,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _image != null
                                    ? CircleAvatar(
                                        radius: 90,
                                        backgroundImage: MemoryImage(_image!),
                                        backgroundColor: Colors.grey[200],
                                      )
                                    : CircleAvatar(
                                        radius: 100,
                                        backgroundImage: const NetworkImage(
                                            "https://cdn4.iconfinder.com/data/icons/documents-36/25/add-picture-512.png"),
                                        backgroundColor: Colors.deepOrange[50],
                                      )
                              ],
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            const Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Product Name",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            const Divider(
                              height: 5,
                              thickness: 1.7,
                              indent: 10,
                              endIndent: 155,
                              color: Colors.deepOrange,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: _publishController.controllerName,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: '',
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Product Price",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            const Divider(
                              height: 5,
                              thickness: 1.7,
                              indent: 10,
                              endIndent: 165,
                              color: Colors.deepOrange,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: _publishController.controllerPrice,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: '',
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Product Description",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            const Divider(
                              height: 5,
                              thickness: 1.7,
                              indent: 10,
                              endIndent: 110,
                              color: Colors.deepOrange,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller:
                                  _publishController.controllerDescription,
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: '  Describe the product...',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 10.0),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text(
                                  "Product Category",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: colorIcon,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(iconCategory),
                                )
                              ],
                            ),
                            const Divider(
                              height: 0,
                              thickness: 1.7,
                              indent: 10,
                              endIndent: 130,
                              color: Colors.deepOrange,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                DropdownMenu<ColorLabel>(
                                  controller: _publishController.useController,
                                  requestFocusOnTap: true,
                                  label: const Text('Use'),
                                  width: 110.0,
                                  onSelected: (ColorLabel? color) {
                                    setState(() {
                                      selectedColor = color;
                                      colorIcon = color!.colorIcon;
                                    });
                                  },
                                  dropdownMenuEntries: ColorLabel.values
                                      .map<DropdownMenuEntry<ColorLabel>>(
                                          (ColorLabel color) {
                                    return DropdownMenuEntry<ColorLabel>(
                                      value: color,
                                      label: color.label,
                                      enabled: color.label != 'Grey',
                                      style: MenuItemButton.styleFrom(
                                        foregroundColor: color.color,
                                      ),
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(width: 20),
                                DropdownMenu<IconLabel>(
                                  controller: _publishController.iconController,
                                  requestFocusOnTap: true,
                                  label: const Text('Category'),
                                  width: 150.0,
                                  onSelected: (IconLabel? icon) {
                                    setState(() {
                                      selectedIcon = icon;
                                      iconCategory = icon!.icon;
                                    });
                                  },
                                  dropdownMenuEntries: IconLabel.values
                                      .map<DropdownMenuEntry<IconLabel>>(
                                          (IconLabel icon) {
                                    return DropdownMenuEntry<IconLabel>(
                                        value: icon,
                                        label: icon.label,
                                        leadingIcon: Icon(icon.icon));
                                  }).toList(),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Colors.deepOrange),
                                ),
                                onPressed: () async {
                                  ProductModel producto = ProductModel(
                                      "100",
                                      _publishController.controllerName.text,
                                      _publishController.iconController.text,
                                      int.parse(_publishController
                                          .controllerPrice.text),
                                      false,
                                      "img",
                                      false,
                                      0);
                                  await _publishController.addProductToCatalog(
                                      producto, selectedImage!);
                                },
                                child: const Text(
                                  'Publish product',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ))
                          ]),
                          Positioned(
                              top: 220,
                              left: 190,
                              child: IconButton(
                                onPressed: () {
                                  showImagePickerOption(context);
                                },
                                icon: const Icon(Icons.add_a_photo),
                                iconSize: 30,
                              )),
                        ],
                      )
                    ],
                  ),
                )),
          ],
        ));
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.deepOrange[200],
        context: context,
        builder: (builder) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                      onTap: () {
                        _pickImageFromGallery();
                      },
                      child: const SizedBox(
                        child: Column(children: [
                          Icon(Icons.image, size: 40),
                          Text("Gallery"),
                        ]),
                      )),
                ),
                Expanded(
                  child: InkWell(
                      onTap: () {
                        _pickImageFromCamera();
                      },
                      child: const SizedBox(
                        child: Column(children: [
                          Icon(
                            Icons.camera,
                            size: 40,
                          ),
                          Text("Camera"),
                        ]),
                      )),
                ),
              ],
            ),
          );
        });
  }

  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnImage == null) return;

    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }

  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }
}
