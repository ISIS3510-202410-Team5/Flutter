import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unimarket/Controllers/search_controllerUnimarket.dart';
import 'package:unimarket/Models/product_model.dart';
import 'package:unimarket/Views/productDetail_view.dart';
import 'package:unimarket/theme.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  late final SearchControllerUnimarket _searcController;
  late List<ProductModel> productsList;
  List<ProductModel> displayList = <ProductModel>[];
  late List<ProductModel> trendingProductsList;

  @override
  void initState() {
    super.initState();
    _searcController = SearchControllerUnimarket();
    //getAllProducts().then((value){getTrendingProducts();});
    //trendingProductsList = getTrendingProducts();
    getAllProducts();
  }

  Future<List<ProductModel>> getAllProducts() async {
    return _searcController.getProducts();
  }

  Future<void> getTrendingProducts() async{
    if(trendingProductsList.isNotEmpty){
      trendingProductsList = productsList;
      trendingProductsList.sort(((a, b) => b.views.compareTo(a.views)));
      trendingProductsList = trendingProductsList.sublist(0,5);
    }
  }
  

  Future<List<ProductModel>> filterTrendingProducts() async {
    trendingProductsList = await Isolate.run(() {
      return _searcController.getProducts().sort(((a, b) => b.views.compareTo(a.views))).sublist(0,5);
    });
    return trendingProductsList;
  }

  void updateList(String value) {
    setState(() {
      displayList = productsList
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  //TODO: To increment the amount of views and re do the filtering
  Future<void> updateTrends(ProductModel product) async {
    setState(() {
      trendingProductsList.sort(((a, b) => b.views.compareTo(a.views)));
      trendingProductsList = trendingProductsList.sublist(0, 5);
    });
  }

  void displayProduct(ProductModel product) {
    setState(() {});
    //product.views++;
    updateTrends(product);
    //Provider.of<BodyView>(context). = ProductDetail_view(product);
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => ProductDetail_view(product)));
  }



  Set<String> selected = {'Selected Product'};

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, child) =>
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: const Column(
              children: [
                Text("New Search",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold
                  )
                ),
                Divider(
                  height: 5,
                  thickness: 3,
                  indent: 80,
                  endIndent: 80,
                  color: Colors.deepOrange,
                ),
              ],
            )
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  width: 500,
                  decoration: BoxDecoration(
                    color: notifier.getTheme().cardColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 20.0),
                      Icon(
                        Icons.fireplace_outlined,
                        color: Colors.orange[900],
                      ),
                      const SizedBox(width: 10.0),
                      const Text("Trending Products",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 1.0),
                
                Container(
                  width: 330,
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(8),
                    itemCount: trendingProductsList.length,
                    itemBuilder: (context, index) => 

                    Container(
                      width: 120,
                      child: Card(
                      color: notifier.getTheme().cardColor,
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              trendingProductsList[index].name,
                              style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4.0),
                            const Divider(
                              height: 1,
                              thickness: 2,
                              color: Colors.deepOrange,
                              indent: 10,
                              endIndent: 10,
                            ),
                            const SizedBox(height: 7.0),
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(trendingProductsList[index].image),
                            ),
                            const SizedBox(height: 7,),
                            Text("Price: ${trendingProductsList[index].price}",
                              style: const TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto'
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                    )
                  ),
                ),
                const SizedBox(height: 10,),
                TextField(
                  onChanged: (value) => updateList(value),
                  controller: _searcController.searchBarController,
                  style: TextStyle(color: notifier.getTheme().dividerColor),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: notifier.getTheme().cardColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Search Products...",
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 15.0),
                Expanded(
                  child: GridView.builder(
                    itemCount: displayList.length,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      mainAxisExtent: 215,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20
                    ),
                    itemBuilder: (context, index) => 
                    Card(
                      color: notifier.getTheme().cardColor,
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              displayList[index].name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4.0),
                            const Divider(
                              height: 1,
                              thickness: 2,
                              color: Colors.deepOrange,
                              indent: 10,
                              endIndent: 10,
                            ),
                            const SizedBox(height: 10.0),

                            CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(displayList[index].image),
                            ),
                            const SizedBox(height: 10,),
                            Text("Price: ${displayList[index].price}",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto'
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}