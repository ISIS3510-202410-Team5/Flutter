import 'package:flutter/material.dart';
import 'package:unimarket/Models/product_model.dart';
import 'package:unimarket/Views/productDetail_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unimarket/Controllers/search_controller.dart';


class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  late SearchCoontroller _searchController;

  @override
  void initState(){
    _searchController = SearchCoontroller();
    super.initState();
  }

  //productos de la base ded datos
  Future<int> productos =
      FirebaseFirestore.instance.collection('productos').snapshots().length;

  static List<ProductModel> productsList = [
    
  ];

  static List<ProductModel> trendingProductsList = productsList;

  List<ProductModel> displayList = List.from(productsList);
  List<ProductModel> trendList = productsList.sublist(0, 5);

  void updateList(String value) {
    setState(() {
      displayList = productsList
          .where((element) =>
              element.product_name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void updateTrends(ProductModel product) {
    setState(() {
      trendingProductsList
          .sort(((a, b) => b.product_views.compareTo(a.product_views)));
      trendList = trendingProductsList.sublist(0, 5);
    });
  }

  void displayProduct(ProductModel product) {
    setState(() {});
    product.product_views++;
    updateTrends(product);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductDetailView(product)));
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
          title: const Column(
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
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) => updateList(value),
              controller: _searchController.searchBarController,
              style: const TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Search Products...",
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 7.0),
            Expanded(
              
              child: GridView.builder(
                itemCount: displayList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) => ListTile(
                  contentPadding: const EdgeInsets.all(7.0),
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
                                displayProduct(displayList[index]);
                              },
                              child: Text(
                                displayList[index].product_name!,
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                    color: Colors.black),
                                selectionColor: Colors.deepOrange[200],
                                textAlign: TextAlign.center,
                              )),
                          const Divider(
                            height: 1,
                            thickness: 1.5,
                            color: Colors.deepOrange,
                            indent: 10,
                            endIndent: 10,
                          ),
                          const SizedBox(height: 6.0),
                          Image.network(
                            displayList[index].product_image!,
                            height: 77,
                            width: 70,
                          ),
                          Text("Price: ${displayList[index].product_price!}",
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto')),
                        ],
                      ))),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              height: 40,
              width: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10.0),
                  Icon(
                    Icons.fireplace_outlined,
                    color: Colors.orange[900],
                  ),
                  const SizedBox(width: 10.0),
                  const Text("Trending Products",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 1.0),
            Expanded(
              child: ListView.builder(
                itemCount: trendList.length,
                itemBuilder: (context, index) => ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
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
                                displayProduct(trendList[index]);
                              },
                              child: Text(
                                trendList[index].product_name!,
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                    color: Colors.black),
                                selectionColor: Colors.deepOrange[200],
                              )),
                          const Divider(
                            height: 1,
                            thickness: 1.5,
                            color: Colors.deepOrange,
                            indent: 10,
                            endIndent: 10,
                          ),
                          const SizedBox(height: 6.0),
                          Image.network(
                            trendList[index].product_image!,
                            height: 130,
                            width: 120,
                          ),
                          Text("Price: ${trendList[index].product_price!}",
                              style: const TextStyle(
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
