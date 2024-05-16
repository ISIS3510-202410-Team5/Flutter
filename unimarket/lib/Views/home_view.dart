import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:light/light.dart';
import 'package:provider/provider.dart';
import 'package:unimarket/Controllers/home_controller.dart';
import 'package:unimarket/Views/search_view/search_view.dart';
import 'package:flutter/services.dart';
import 'package:unimarket/theme.dart';
import 'package:unimarket/resources/connectivity_service.dart';

enum IconLabel {
  paint('Art Materials', Icons.format_paint),
  audiovisuals('Audiovisuals', Icons.camera_rounded),
  security('Security', Icons.security_rounded),
  books('Books', Icons.book),
  hardware('Hardware', Icons.computer_rounded),
  noCategory('None', Icons.error);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final StreamController<int> _controller = StreamController<int>();

  late HomeController _homeController;
  Light? _light;
  StreamSubscription? _subscription;

  String? _luxString;
  bool toggle = true;
  bool isDarkTheme = false;
  bool isConnected = true;
  late bool sessionThemeConfigured;

  void onData(int luxValue) async {
    double lightLevel = double.tryParse('$luxValue') ?? 0.0;
    //print("Lux value: $luxValue");
    setState(() {
      _luxString = "$luxValue";
    });
    if (lightLevel <= 10.0 && !isDarkTheme && !sessionThemeConfigured) {
      showDarkThemeDialog(context);
      sessionThemeConfigured = true;
      print('Error 1');
    } else if (lightLevel >= 40 && isDarkTheme && !sessionThemeConfigured) {
      print('Error 2');
      showLightThemeDialog(context);
      sessionThemeConfigured = true;
    }
  }

  void stopListening() {
    _subscription?.cancel();
  }

  void startListening() {
    _light = Light();
    try {
      _subscription = _light?.lightSensorStream.listen(onData);
    } on LightException catch (exception) {
      print(exception);
    }
  }

  @override
  void initState() {
    // Note that you cannot use `async await` in  initState
    super.initState();
    getData();
    getData1();
    _homeController = HomeController();
    initPlatformState();
    sessionThemeConfigured = false;
  }

  Future<void> initPlatformState() async {
    startListening();
  }

  final db = FirebaseFirestore.instance;

  int numProds = 0;
  int usuariosN = 0;

  searchSelection() async {
    isConnected ? 
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => SearchView(categoryIndex: 5))
      ) 
      : showNoConnectionDialog(context, 5);
  }

  List data = [];
  void getData() async {
    await FirebaseFirestore.instance
        .collection("productos")
        .get()
        .then((value) {
      for (var i in value.docs) {
        data.add(i.data());
      }
    });
    setState(() => numProds = data.length);
  }

  List usuarios = [];
  void getData1() async {
    await FirebaseFirestore.instance.collection("users").get().then((value) {
      for (var i in value.docs) {
        usuarios.add(i.data());
      }
    });
    setState(() => usuariosN = usuarios.length);
  }

  // int contarProductos() {

  //    Future<List<Producto>> productList = productos();
  //   // Iterate over the list of products
  //   Future.forEach((producto) {
  //     // Perform actions with each product
  //     print('Product ID: ${producto.id}, Name: ${producto.name}');
  //   } as Iterable);
  //   print(productos()..toString() +
  //       "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
  //   return 1;
  // }

  void showDarkThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Dark Theme Suggestion'),
          content: const Text(
            'We have noticed that you are in a place without too much light. Would you like to change to the Dark Mode?'
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<ThemeNotifier>(context, listen: false).toogleTheme();
                Navigator.of(context).pop();
              },
              child: const Text('Accept'),
            ),
          ],
        );
      },
    );
  }

  void showLightThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[800],
          title: const Text('Light Theme Suggestion'),
          content: const Text(
            'We have noticed that you are in a place with a lot of light. Would you like to change to the Light Mode?'
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<ThemeNotifier>(context, listen: false).toogleTheme();
                Navigator.of(context).pop();
              },
              child: const Text('Accept'),
            ),
          ],
        );
      },
    );
  }

  showNoConnectionDialog(BuildContext context, int categoryIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Provider.of<ThemeNotifier>(context).getTheme().cardColor,
          title: const Text('No internet connection'),
          content: const Text(
            'Seems to be that your device has no connection in this moment. You will be redirected to the search view but you wont be able to do a search'
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SearchView(categoryIndex: categoryIndex))
                );
              },
              child: const Text('Accept'),
            ),
          ],
        );
      },
    );
  }

  void setCategorySearch(int categoryIndex){
    isConnected ? 
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => SearchView(categoryIndex: categoryIndex))
      ) 
      : showNoConnectionDialog(context, categoryIndex);
  }

  @override
  Widget build(BuildContext context) {
    isDarkTheme = Provider.of<ThemeNotifier>(context).darkTheme;
    var networkStatus = Provider.of<NetworkStatus>(context);

    networkStatus == NetworkStatus.offline ? isConnected = false : isConnected = true;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ListView(
        children: [
          const SizedBox(height: 20,),

          const Align(
            alignment: Alignment.center,
            child: Text(
              "Welcome to Unimarket",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),

          const Divider(
            height: 5,
            thickness: 3,
            indent: 50,
            endIndent: 50,
            color: Colors.deepOrange,
          ),

          const SizedBox(height: 15,),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Number of users:",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                
                Text(
                  usuariosN.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Number of products:",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                
                Text(
                  numProds.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15,),

          Row(
            children: [
              const SizedBox(width: 30,),

              SizedBox(
                height: 50,
                width: 300,
                child: TextField(
                  onTap: () {
                    searchSelection();
                    getData();
                  },
                  style: const TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Provider.of<ThemeNotifier>(context)
                      .getTheme()
                      .cardColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Search Products...",
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(width: 30,),
            ],
          ),
          Consumer<ThemeNotifier>(
            builder: (context, notifier, child) => 
              Card(
                margin: const EdgeInsets.all(20.0),
                color: notifier.getTheme().cardColor,
                child: Column(
                  children: [
                    const SizedBox(height: 10,),

                    const Row(
                      children: [
                        SizedBox(width: 40,),

                        Text(
                          "What are you looking for?",
                          style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    
                    const Divider(
                      thickness: 3,
                      color: Colors.grey,
                      indent: 30,
                      endIndent: 30,
                    ),
                        
                    const SizedBox(height: 40,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Card(
                              color: notifier.getTheme().dividerColor,
                              child: InkWell(
                                onTap: () async {
                                  setCategorySearch(0);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.deepOrange,
                                          width: 5
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.format_paint,
                                            size: 65,
                                            color: notifier.getTheme().hintColor
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ),
                            ),
                                
                            const Text(
                              "Art Materials",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                            
                        const SizedBox(width: 60,),

                        Column(
                          children: [
                            Card(
                              color: notifier.getTheme().dividerColor,
                              child: InkWell(
                                onTap: () {
                                  setCategorySearch(1);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.deepOrange,
                                          width: 5),
                                      ),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.camera_rounded,
                                            size: 65,
                                            color: notifier.getTheme().hintColor
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ),
                            ),

                            const Text(
                              "Audiovisuals",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                        
                    const SizedBox(height: 60,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Card(
                              color: notifier.getTheme().dividerColor,
                              child: InkWell(
                                onTap: () {
                                  setCategorySearch(2);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.deepOrange,
                                          width: 5
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.security_rounded,
                                            size: 65,
                                            color: notifier.getTheme().hintColor
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ),
                            ),
                                
                            const Text(
                              "Security",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                            
                        const SizedBox(width: 60,),

                        Column(
                          children: [
                            Card(
                              color: notifier.getTheme().dividerColor,
                              child: InkWell(
                                onTap: () {
                                  setCategorySearch(3);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.deepOrange,
                                          width: 5),
                                        ),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.book,
                                            size: 65,
                                            color: notifier.getTheme().hintColor
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                                
                            const Text(
                               "Books",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                        
                    const SizedBox(height: 60,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Card(
                              color: notifier.getTheme().dividerColor,
                              child: InkWell(
                                onTap: () {
                                  setCategorySearch(4);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.deepOrange,
                                          width: 5
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.computer_rounded,
                                            size: 65,
                                            color: notifier.getTheme().hintColor
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ),
                            ),
                                
                            const Text(
                              "Hardware",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}
