import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unimarket/Views/search_view.dart';
import 'package:unimarket/modelo/productos.dart';
import 'package:flutter/services.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    // Note that you cannot use `async await` in  initState
    getData();
    getData1();
    super.initState();
  }

  final _DB = FirebaseFirestore.instance;

  int numProds = 0;
  int usuariosN = 0;
  void searchSelection() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SearchView()));
  }

  Future<List<Producto>> productos() async {
    final snapshot = await _DB.collection("productos").get();

    final prods = snapshot.docs.map((e) => Producto.fromSnapshot(e)).toList();
    return prods;
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
    setState(() => usuariosN = usuarios[0]["regUsers"]);
    print(usuarios[0] +
        "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[200],
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Welcome to Unimarket",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            height: 5,
            thickness: 3,
            indent: 50,
            endIndent: 50,
            color: Colors.deepOrange,
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            onTap: () {
              searchSelection();
              getData();
            },
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(60.0),
                borderSide: BorderSide.none,
              ),
              hintText: "Search Products...",
              prefixIcon: Icon(Icons.search),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            margin: EdgeInsets.all(11.0),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "What are you looking for?",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(
                  thickness: 3,
                  color: Colors.grey,
                  indent: 30,
                  endIndent: 30,
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: Colors.deepOrange, width: 5),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.format_paint,
                                size: 65,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Art Materials",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: Colors.deepOrange, width: 5),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.camera_rounded,
                                size: 65,
                              ),
                            ],
                          ),
                        ),
                        Text("Audiovisuals",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: Colors.deepOrange, width: 5),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.security_rounded,
                                size: 65,
                              ),
                            ],
                          ),
                        ),
                        Text("Security",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: Colors.deepOrange, width: 5),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.book,
                                size: 65,
                              ),
                            ],
                          ),
                        ),
                        Text("Books",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: Colors.deepOrange, width: 5),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.computer_rounded,
                                size: 65,
                              ),
                            ],
                          ),
                        ),
                        Text("Hardware",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Number of users:",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                // Replace the value of usersCount with your variable
                Text(
                  usuariosN.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Number of products:",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                // Replace the value of productsCount with your variable
                Text(
                  numProds.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
