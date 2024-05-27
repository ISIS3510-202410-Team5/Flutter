import 'dart:isolate';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unimarket/Controllers/search_controllerUnimarket.dart';
import 'package:unimarket/Models/product_model.dart';
import 'package:unimarket/Views/productDetail_view.dart';
import 'package:unimarket/resources/connectivity_service.dart';
import 'package:unimarket/resources/shimmer_effect.dart';
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
  hardware('Hardware', Icons.computer_rounded),
  noCategory('None', Icons.error);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}

class SearchView extends StatefulWidget {

  final int categoryIndex;

  SearchView({super.key,required this.categoryIndex});

  @override
  State<SearchView> createState() => _SearchViewState();
}

void isolateFunction(List arguments) async {
  SendPort sendPort = arguments[0];
  List<ProductModel> prodList = arguments[1];
  List<ProductModel> trendingList = [];

  prodList.sort((a,b)=> b.views.compareTo(a.views));
  trendingList = prodList.sublist(0,5);

  sendPort.send(trendingList);
}

class _SearchViewState extends State<SearchView> {

  late final SearchControllerUnimarket _searcController;
  List<ProductModel> productsList = <ProductModel>[];
  late List<ProductModel> filteredList;
  late List<ProductModel> displayList;
  List<ProductModel> trendingProductsList = <ProductModel>[];
  late Future<List<ProductModel>> trendingList;

  bool isLoadingFiltered = false;
  bool isLoadingTrends = false;
  bool isSearchDone = false;
  bool trendsReady = false;

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
    filterTrendingProducts().then((value) => setState(() {
      trendsReady = true;
    }));
    IconLabel.values[widget.categoryIndex] == IconLabel.noCategory ?
      print("nada") : {selectedIcon = IconLabel.values[widget.categoryIndex]};
  }

  Future<List<ProductModel>> getAllProducts() async {
    productsList = _searcController.getProducts();
    return productsList;
  }


  filterTrendingProducts() async {

    final receivePort = ReceivePort();
    List<ProductModel> prodList = await _searcController.getAllProducts();
    
    Isolate.spawn(isolateFunction, [receivePort.sendPort, prodList]);

    trendingProductsList = await receivePort.first;
  }

  filterTrendingProducts2() async {

    List<ProductModel> prodList = await _searcController.getAllProducts();
    prodList.sort((a,b)=> b.views.compareTo(a.views));
    trendingProductsList = prodList.sublist(0,5);

    await Future.wait(
      trendingProductsList.map((product) => cacheImage(context, product.image)).toList()
    );
    //await Future.delayed(const Duration(seconds: 3), (){});
    setState(() {
      trendsReady = true;
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
    setState(() {
      isSearchDone = true;
      isLoadingFiltered = true;
    });

    bool used;
    selectedColor!.label == 'Never used' ? used = false : used = true;
    List<ProductModel> listaProds = await _searcController.getFilteredProducts(selectedIcon!.label, used);

    await Future.wait(
      listaProds.map((product) => cacheImage(context, product.image)).toList()
    );

    //await Future.delayed(const Duration(seconds: 5), (){});

    setState(() {
      filteredList = listaProds;
      filtersAplied = true;
      searchEnabled = true;
      isLoadingFiltered = false;
    });
    updateList('', notifier);
  }

  Future cacheImage(BuildContext context, String urlImage)=> precacheImage(
    CachedNetworkImageProvider(urlImage), 
    context
  );

  incrementTrend(ProductModel prod){
    _searcController.incrementViews(prod);
  }

  void showNoConnectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Provider.of<ThemeNotifier>(context).getTheme().cardColor, // Set background color to green
          title: const Text('No internet connection'),
          content: const Text(
              'Seems to be that your device has no connection in this moment. Please check your connection and try again'),
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
          body: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              Column(
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
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(8),
                    itemCount: trendsReady ? trendingProductsList.length : 5,
                    itemBuilder: (context, index) => 
                      trendsReady ? 
                        Container(
                          width: 120,
                          child: Card(
                            color: notifier.getTheme().cardColor,
                            child: InkWell(
                              onTap: () async {
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetail_view(trendingProductsList[index])
                                  )
                                ); 
                                await incrementTrend(trendingProductsList[index]);
                                filterTrendingProducts2();
                              },
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
                                    backgroundImage: CachedNetworkImageProvider(trendingProductsList[index].image),
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
                      : ShimmerWidget.circular(
                            width: 110, 
                            height: 15, 
                            shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                            )
                          ),
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
                      initialSelection: selectedIcon,
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

                    IconButton(onPressed: () async {
                      networkStatus == NetworkStatus.online ? 
                        (selectedColor!=null && selectedIcon!=null) ?
                          await requestFilteredProducts(notifier)
                          : showFilterDialog(context)
                        : showNoConnectionDialog(context);
                      }, 
                      icon: const Icon(Icons.check_circle_outlined)
                    )
                  ],
                ),

                const SizedBox(height: 20,),

                const SizedBox(height: 10,),

                (networkStatus == NetworkStatus.online) ?
                    (!isSearchDone ? 
                      const Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(image: AssetImage('assets/images/search_something.png'), height: 160, width: 150,),
                            SizedBox(height: 10,),
                            Text('Search Something...',
                              style: TextStyle(
                                fontWeight: FontWeight.bold, 
                                fontSize: 17
                              ),
                            ),
                          ],
                        ),
                      )
                      : ((displayList.isEmpty && !isLoadingFiltered) ? 
                              const Align(
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(image: AssetImage('assets/images/no_search_results.png'), height: 160, width: 150,),
                                    SizedBox(height: 10,),
                                    Text('No results. Try again',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold, 
                                        fontSize: 17
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              : Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                
                                  children: [
                                    GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: isLoadingFiltered ? 4 : displayList.length,
                                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 300,
                                    mainAxisExtent: 220,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 20
                                  ),
                                  itemBuilder: (context, index) => 
                                    (isLoadingFiltered) ? 
                                      ShimmerWidget.circular(
                                        width: 30, 
                                        height: 20, 
                                        shapeBorder: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)
                                        )
                                      ) 
                                    : Card(
                                    color: notifier.getTheme().cardColor,
                                    child: InkWell(
                                      onTap: () async {
                                        Navigator.push(
                                          context, 
                                          MaterialPageRoute(
                                          builder: (context) => ProductDetail_view(displayList[index])
                                          )
                                        ); 
                                        await incrementTrend(trendingProductsList[index]);
                                        filterTrendingProducts2();
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
                                            backgroundImage: CachedNetworkImageProvider(displayList[index].image),
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
                                
                                  const SizedBox(height: 20,)
                                  ],
                                ),
                              )
                              
                            )
                    ) 
                    : (filteredList.isEmpty ? 
                        const Align(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(image: AssetImage('assets/images/no_internet_connection.png'), height: 160, width: 150,),
                              SizedBox(height: 10,),
                              Text('No internet connection',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, 
                                  fontSize: 17
                                ),
                              ),
                            ],
                          ),
                        )
                        : ((displayList.isEmpty && !isLoadingFiltered) ? 
                              const Align(
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(image: AssetImage('assets/images/no_search_results.png'), height: 160, width: 150,),
                                    SizedBox(height: 10,),
                                    Text('No results. Try again',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold, 
                                        fontSize: 17
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              : Column(
                                children: [
                                  GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: isLoadingFiltered ? 4 : displayList.length,
                                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 300,
                                    mainAxisExtent: 220,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 20
                                  ),
                                  itemBuilder: (context, index) => 
                                    (isLoadingFiltered) ? 
                                      ShimmerWidget.circular(
                                        width: 30, 
                                        height: 20, 
                                        shapeBorder: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)
                                        )
                                      ) 
                                    : Card(
                                    color: notifier.getTheme().cardColor,
                                    child: InkWell(
                                      onTap: () async {
                                        Navigator.push(
                                          context, 
                                          MaterialPageRoute(
                                          builder: (context) => ProductDetail_view(displayList[index])
                                          )
                                        ); 
                                        await incrementTrend(trendingProductsList[index]);
                                        filterTrendingProducts2();
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
                                            backgroundImage: CachedNetworkImageProvider(displayList[index].image),
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
                                const SizedBox(height: 20,),
                                ],
                              )
                              
                            )
                      )
              ],
            ),
            ],
          )
        )
    );
  }
}