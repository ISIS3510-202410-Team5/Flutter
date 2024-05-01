import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unimarket/Controllers/search_controllerUnimarket.dart';
import 'package:unimarket/Models/product_model.dart';
import 'package:unimarket/Views/productDetail_view.dart';
import 'package:unimarket/resources/connectivity_service.dart';
import 'package:unimarket/theme.dart';

enum ColorLabel {
  newProduct('Never used', Colors.yellow),
  oldProduct('Second-hand', Colors.grey);

  const ColorLabel(this.label, this.colorIcon);
  final String label;
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

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  late final SearchControllerUnimarket _searcController;
  List<ProductModel> productsList = <ProductModel>[];
  late List<ProductModel> filteredList;
  late List<ProductModel> displayList;
  List<ProductModel> trendingProductsList = <ProductModel>[];

  ColorLabel? selectedColor;
  IconLabel? selectedIcon;
  Color colorIcon = Colors.deepOrange;
  IconData iconCategory = Icons.question_mark;
  bool filtersAplied = false;
  bool searchEnabled = true;
  

  @override
  void initState() {
    super.initState();
    _searcController = SearchControllerUnimarket();
    displayList = <ProductModel>[];
    filteredList = <ProductModel>[];
    //getAllProducts().then((value){getTrendingProducts();});
    //filterTrendingProducts();
    //getAllProducts();
  }

  Future<List<ProductModel>> getAllProducts() async {
    productsList = _searcController.getProducts();
    return productsList;
  }

  Future<void> getTrendingProducts() async{
    if(productsList.isNotEmpty){
      trendingProductsList = productsList;
      trendingProductsList.sort(((a, b) => b.views.compareTo(a.views)));
      trendingProductsList = trendingProductsList.sublist(0,5);
    }
  }
  

  Future<void> filterTrendingProducts() async {
    await Isolate.run(() {
      _searcController.getProducts().sort(((a, b) => b.views.compareTo(a.views))).sublist(0,5);
    });
  }

  void updateList(String value, ThemeNotifier notifier) {
    setState(() {
      displayList = filteredList
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

  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Provider.of<ThemeNotifier>(context).getTheme().cardColor, // Set background color to green
          title: const Text('No filters added'),
          content: const Text(
              'Please choose an option for the category and the use of the product'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Accept'),
            ),
          ],
        );
      },
    );
  }


  requestFilteredProducts(ThemeNotifier notifier) async {
    bool used;
    selectedColor!.label == 'Never used' ? used = false : used = true;
    List<ProductModel> listaProds = await _searcController.getFilteredProducts(selectedIcon!.label, used);
    setState(() {
      filteredList = listaProds;
      filtersAplied = true;
      searchEnabled = true;
    });
    updateList('', notifier);
  }


  Set<String> selected = {'Selected Product'};

  @override
  Widget build(BuildContext context) {

    var networkStatus = Provider.of<NetworkStatus>(context);

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
                
                const SizedBox(height: 15.0),

                TextField(
                  onChanged: (value) => updateList(value, notifier),
                  onTap: (){
                    filtersAplied ? {print("Search Enabled")} 
                      : {showFilterDialog(context), setState(() {
                        searchEnabled = false;
                      })};
                  },
                  enabled: searchEnabled,
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

                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownMenu<ColorLabel>(
                      controller: _searcController.useController,
                      requestFocusOnTap: true,
                      enableSearch: false,
                      enableFilter: false,
                      label: const Text('Use'),
                      width: 110.0,
                      onSelected: (ColorLabel? color) {
                        setState(() {
                          selectedColor = color;
                          colorIcon = color!.colorIcon;
                          filtersAplied = false;
                        });
                      },
                      dropdownMenuEntries: ColorLabel.values
                        .map<DropdownMenuEntry<ColorLabel>>(
                          (ColorLabel color) {
                            return DropdownMenuEntry<ColorLabel>(
                              value: color,
                              label: color.label,
                              enabled: color.label != 'Grey',
                            );
                          }).toList(),
                    ),
                    const SizedBox(width: 20),
                    DropdownMenu<IconLabel>(
                      controller: _searcController.iconController,
                      requestFocusOnTap: true,
                      label: const Text('Category'),
                      width: 150.0,
                      onSelected: (IconLabel? icon) {
                        setState(() {
                          selectedIcon = icon;
                          iconCategory = icon!.icon;
                          filtersAplied = false;
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

                    IconButton(onPressed: () async {await requestFilteredProducts(notifier);}, icon: const Icon(Icons.check_circle_outlined))
                  ],
                ),

                const SizedBox(height: 20,),

                Expanded(
                  child: (networkStatus == NetworkStatus.online) ?
                    ((displayList.isEmpty)? const Text("No Results"):
                    GridView.builder(
                      itemCount: displayList.length,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        mainAxisExtent: 220,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20
                      ),
                      itemBuilder: (context, index) => 
                      Card(
                        color: notifier.getTheme().cardColor,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                              builder: (context) => ProductDetail_view(displayList[index])
                              )
                            ); 
                          },
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
                    )
                  ) : (displayList.isEmpty ? const Text('No results :(') : const Text('No connection') )
                ),
              ],
            ),
          ),
        )
    );
  }
}