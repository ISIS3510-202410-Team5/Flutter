import 'package:flutter/material.dart';
import 'package:unimarket/Controllers/Controller.dart';
import 'package:unimarket/Model/model.dart';
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
  List<ProductModel> products_list = Controller().getProducts();

  late List<ProductModel> trending_products_list = products_list;

  late List<ProductModel> display_list = List.from(products_list);
  late List<ProductModel> trend_list = products_list.sublist(0, 5);

  void updateList(String value) {
    setState(() {
      display_list = products_list
          .where((element) =>
              element.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void updateTrends(ProductModel product) {
    setState(() {
      trending_products_list.sort(((a, b) => b.views.compareTo(a.views)));
      trend_list = trending_products_list.sublist(0, 5);
    });
  }

  void displayProduct(ProductModel product) {
    setState(() {});
    product.views++;
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
                      height: 500,
                      child: Expanded(
                          child: Column(
                        children: [
                          TextButton(
                              onPressed: () {
                                displayProduct(display_list[index]);
                              },
                              child: Text(
                                display_list[index].name!,
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
                            display_list[index].image!,
                            height: 77,
                            width: 70,
                          ),
                          Text("Price: ${display_list[index].price!}",
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
                      height: 220,
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
                                trend_list[index].name!,
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
                            trend_list[index].image!,
                            height: 130,
                            width: 120,
                          ),
                          Text("Price: ${trend_list[index].price!}",
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
            )
          ],
        ),
      ),
    );
  }
}
