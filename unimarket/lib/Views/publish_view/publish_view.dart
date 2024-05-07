import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:unimarket/Controllers/publish_controller.dart';
import 'package:unimarket/Models/product_model.dart';
import 'package:unimarket/Views/publish_view/input_field.dart';
import 'package:unimarket/Views/publish_view/settings_provider.dart';
import 'package:unimarket/resources/connectivity_service.dart';
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

  bool isUploaded = false;

  //For the verifications
  final settingsProvider = SettingsProvider();
  final formKey = GlobalKey<FormState>();

  //For the elevated button
  bool _isDisabled = false;

  @override
  void initState() {
    _publishController = PublishController();
    super.initState();
  }

  createProduct(String name, String category, int price, bool use, String description) async {

    ProductModel producto = ProductModel(null, name, category, price, use, 'null', false, 0, description, 'null');
    await _publishController.addProductToCatalog(producto, selectedImage!);
    //await Future.delayed(const Duration(seconds: 10), (){});
    
    setState(() {
      isUploaded = true;
    });
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          
          backgroundColor: Provider.of<ThemeNotifier>(context).getTheme().cardColor,
          content: LoadingAnimationWidget.newtonCradle(color: Colors.black, size: 90),
        );
      },
    );
  }

  void showUploadedDialog(BuildContext context) {

    Navigator.of(context).pop();
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Provider.of<ThemeNotifier>(context).getTheme().cardColor, // Set background color to green
          title: const Text('¡¡Success!!'),
          content: const Text(
              'Your product was successfully added to the database. Go and search it in the search view!!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  isUploaded = false;
                });
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  void showErrorFieldDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Provider.of<ThemeNotifier>(context).getTheme().cardColor, // Set background color to green
          title: const Text('Cannot create a product'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //For the connection check
    var networkStatus = Provider.of<NetworkStatus>(context);

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
                  padding: const EdgeInsets.all(18.0),
                  child: Form(
                    key: formKey,
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
                              InputField(
                                icon: Icons.text_fields_rounded,
                                label: "Name",
                                controller: _publishController.controllerName,
                                maxLength: 20,
                                validator: (value) => settingsProvider.nameValidator(value, "The product name is required"),
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
                                      fontWeight: FontWeight.bold
                                    )
                                  ),
                                ],
                              ),
                              const Divider(
                                height: 5,
                                thickness: 1.7,
                                indent: 10,
                                endIndent: 165,
                                color: Colors.deepOrange,
                              ),
                              const SizedBox(height: 10,),
                              InputField(
                                icon: Icons.price_change_outlined,
                                label: "Price",
                                controller: _publishController.controllerPrice,
                                inputFormat: [FilteringTextInputFormatter.digitsOnly],
                                inputType: TextInputType.phone,
                                validator: (value) => settingsProvider.priceValidator(value),
                              ),
                              const SizedBox(height: 20,),
                              const Row(
                                children: [
                                  SizedBox(width: 20,),

                                  Text("Product Description",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold
                                    )
                                  ),
                                ],
                              ),
                              const Divider(
                                height: 5,
                                thickness: 1.7,
                                indent: 10,
                                endIndent: 110,
                                color: Colors.deepOrange,
                              ),

                              const SizedBox(height: 10,),

                              InputField(
                                icon: Icons.description_rounded,
                                label: "Description",
                                controller: _publishController.controllerDescription,
                                inputType: TextInputType.multiline,
                                maxLines: 5,
                                maxLength: 120,
                                validator: (value) => settingsProvider.descriptionValidator(value),
                              ),

                              const SizedBox(height: 20,),

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
                                  backgroundColor:MaterialStatePropertyAll<Color>(Colors.deepOrange),
                                ),
                                onPressed: _isDisabled ? null : () async {

                                  setState(() {
                                    _isDisabled = true;
                                  });

                                  if(networkStatus == NetworkStatus.online){

                                  } else{
                                    
                                  }

                                    if(_image!=null){
                                      if(formKey.currentState!.validate()){
                                        if(selectedColor!=null){
                                          if(selectedIcon!=null){

                                            showLoadingDialog(context);

                                            await createProduct(
                                              _publishController.controllerName.text, 
                                              selectedIcon!.label, 
                                              int.parse(_publishController.controllerPrice.text), 
                                              selectedColor!.label == 'Never used' ? false : true, 
                                              _publishController.controllerDescription.text
                                            );
                                            _publishController.controllerName.clear();
                                            _publishController.useController.clear();
                                            _publishController.iconController.clear();
                                            _publishController.controllerPrice.clear();
                                            _publishController.controllerDescription.clear();

                                            setState(() {
                                              colorIcon = Colors.deepOrange;
                                              iconCategory = Icons.question_mark;
                                              _image = null;
                                              _isDisabled = false;
                                            });

                                            showUploadedDialog(context);

                                          } else {
                                            showErrorFieldDialog(context, "Please select a category for the product");
                                          }
                                        } else {
                                          showErrorFieldDialog(context, "Please select a use for the product");
                                        }
                                      } else {
                                        showErrorFieldDialog(context, "Please check if you are satisfying the requirements of each field");
                                      }
                                    } else {
                                      showErrorFieldDialog(context, "Please select an image for the product");
                                    }
                                  },
                                child: const Text(
                                  'Publish product',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                ),
                              )
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
                  )
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
