import 'package:flutter/material.dart';
import 'package:unimarket/Model/product_model.dart';
import 'package:unimarket/Views/productDetail_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  //productos de la base ded datos
  Future<int> productos =
      FirebaseFirestore.instance.collection('productos').snapshots().length;

  static List<ProductModel> products_list = [
    ProductModel(0, "Libro Anadec", "Book", 67000, "New product",
        "https://image.cdn0.buscalibre.com/2992268.__RS360x360__.jpg", 0),
    ProductModel(
        1,
        "Libro Anadec",
        "Book",
        50000,
        "Used product",
        "https://th.bing.com/th/id/OIP.22Gl4tn8EHYC4YiYjSF5tQAAAA?rs=1&pid=ImgDetMain",
        0),
    ProductModel(2, "Libro Fisica 2", "Book", 80000, "New product",
        "https://www.etp.com.py/img/tapa-mediana-8955.jpg", 0),
    ProductModel(
        3,
        "Libro Fisica 2",
        "Book",
        70000,
        "Used product",
        "https://th.bing.com/th/id/OIP.l3XVMN3H6pOOTM5GNg1o0gAAAA?rs=1&pid=ImgDetMain",
        0),
    ProductModel(
        4,
        "Libro Fisica 2",
        "Book",
        75000,
        "New product",
        "https://http2.mlstatic.com/D_NQ_NP_674359-MLC47188618536_082021-O.jpg",
        0),
    ProductModel(
        5,
        "Calculadora Científica Casio",
        "School",
        140000,
        "Used product",
        "https://http2.mlstatic.com/calculadora-cientifica-casio-fx-82ms-D_NQ_NP_622288-MLM40187065116_122019-F.jpg",
        0),
    ProductModel(
        6,
        "Calculadora Científica Casio",
        "School",
        120000,
        "Used product",
        "https://http2.mlstatic.com/cientifica-casio-calculadora-D_NQ_NP_307515-MLB25257392781_012017-F.jpg",
        0),
    ProductModel(
        7,
        "Calculadora Científica Casio",
        "School",
        130000,
        "Used product",
        "https://www.papeleriaomega.com.mx/imagenessia/018001.jpg",
        0),
    ProductModel(
        8,
        "Compas",
        "School",
        10000,
        "New product",
        "https://th.bing.com/th/id/R.71214ae37a4834b34a14b1fc4a1d75b3?rik=3qp33D35d%2bFPWg&riu=http%3a%2f%2fmedia.ldlc.com%2fld%2fproducts%2f00%2f03%2f92%2f94%2fLD0003929483_2.jpg&ehk=V3khYkkar5yQJB6m88Iv0fAD4hnTtfHueKo7TAXJnSo%3d&risl=&pid=ImgRaw&r=0",
        0),
    ProductModel(
        9,
        "Compas",
        "School",
        7000,
        "New product",
        "https://image.ceneostatic.pl/data/products/37909381/f-kamet-cyrkiel-szkolny-kamet.jpg",
        0),
  ];

  static List<ProductModel> trending_products_list = products_list;

  List<ProductModel> display_list = List.from(products_list);
  List<ProductModel> trend_list = products_list.sublist(0, 5);

  void updateList(String value) {
    setState(() {
      display_list = products_list
          .where((element) =>
              element.product_name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void updateTrends(ProductModel product) {
    setState(() {
      trending_products_list
          .sort(((a, b) => b.product_views.compareTo(a.product_views)));
      trend_list = trending_products_list.sublist(0, 5);
    });
  }

  void displayProduct(ProductModel product) {
    setState(() {});
    product.product_views++;
    updateTrends(product);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductDetail_view(product)));
  }

  Set<String> selected = {'Selected Product'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Column(
            children: [
              Text("New Search",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold)),
              Divider(
                height: 5,
                thickness: 3,
                indent: 80,
                endIndent: 80,
                color: Colors.deepOrange,
              ),
            ],
          )),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) => updateList(value),
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Search Products...",
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 7.0),
            Expanded(
              child: GridView.builder(
                itemCount: display_list.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) => ListTile(
                  contentPadding: EdgeInsets.all(7.0),
                  title: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Expanded(
                          child: Column(
                        children: [
                          TextButton(
                              onPressed: () {
                                displayProduct(display_list[index]);
                              },
                              child: Text(
                                display_list[index].product_name!,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                    color: Colors.black),
                                selectionColor: Colors.deepOrange[200],
                                textAlign: TextAlign.center,
                              )),
                          Divider(
                            height: 1,
                            thickness: 1.5,
                            color: Colors.deepOrange,
                            indent: 10,
                            endIndent: 10,
                          ),
                          SizedBox(height: 6.0),
                          Image.network(
                            display_list[index].product_image!,
                            height: 90,
                            width: 70,
                          ),
                          Text("Price: ${display_list[index].product_price!}",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto')),
                        ],
                      ))),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 40,
              width: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  SizedBox(width: 10.0),
                  Icon(
                    Icons.fireplace_outlined,
                    color: Colors.orange[900],
                  ),
                  SizedBox(width: 10.0),
                  Text("Trending Products",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(height: 1.0),
            Expanded(
              child: ListView.builder(
                itemCount: trend_list.length,
                itemBuilder: (context, index) => ListTile(
                  contentPadding: EdgeInsets.all(8.0),
                  title: Column(children: [
                    Container(
                      height: 200,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        children: [
                          TextButton(
                              onPressed: () {
                                displayProduct(trend_list[index]);
                              },
                              child: Text(
                                trend_list[index].product_name!,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                    color: Colors.black),
                                selectionColor: Colors.deepOrange[200],
                              )),
                          Divider(
                            height: 1,
                            thickness: 1.5,
                            color: Colors.deepOrange,
                            indent: 10,
                            endIndent: 10,
                          ),
                          SizedBox(height: 6.0),
                          Image.network(
                            trend_list[index].product_image!,
                            height: 130,
                            width: 120,
                          ),
                          Text("Price: ${trend_list[index].product_price!}",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto')),
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
