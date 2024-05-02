import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unimarket/Controllers/productDetail_controller.dart';
import 'package:unimarket/Models/product_model.dart';
import 'package:unimarket/Models/seller_model.dart';
import 'package:unimarket/theme.dart';

class ProductDetail_view extends StatelessWidget {
  late final ProductModel product;

  ProductDetail_view(ProductModel prod) {
    product = prod;
  }

  @override
  Widget build(BuildContext context) {
    void addProductToCart() {}

    SellerModel seller = SellerModel('Seller name', 3214567890, 'seller@gmail.com', 4, 'null');

    return Consumer<ThemeNotifier>(
      builder: (context, notifier, child) =>
        Scaffold(
          appBar: AppBar(
            title: const Column(
              children: [
                Text("Product Info",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold
                  )
                ),

                Divider(
                  height: 5,
                  thickness: 3,
                  indent: 50,
                  endIndent: 50,
                  color: Colors.deepOrange,
                ),
              ],
            )
          ),

          body: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 8,),

                    Container(
                      width: 250,
                      height: 35,
                      decoration: BoxDecoration(
                        color: notifier.getTheme().cardColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 10,),

                              Icon(
                                Icons.info,
                                color: Colors.orange[900],
                              ),

                              const SizedBox(width: 20,),

                              const Text(
                                "General Information",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ]
                          ),

                          const Divider(
                            height: 3,
                            thickness: 3,
                            indent: 46,
                            endIndent: 20,
                            color: Colors.grey
                          ),
                        ],
                      )
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: notifier.getTheme().cardColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.all(11.0),
                      child: Row(
                        children: [
                          const SizedBox(width: 10,),

                          Image.network(
                            product.image,
                            height: 200,
                            width: 150,
                          ),

                          const SizedBox(width: 20,),

                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5,),
                                
                                const Text(
                                  "Product Name",
                                  style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                ),

                                Divider(
                                  color: Colors.deepOrange[600],
                                  height: 5,
                                  thickness: 2.0,
                                  endIndent: 60,
                                ),

                                const SizedBox(height: 5,),

                                Align(
                                  alignment: Alignment.center,
                                  child: Text(product.name),
                                ),

                                const SizedBox(height: 10,),

                                const Text(
                                  "Product Type",
                                  style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                ),

                                Divider(
                                  color: Colors.deepOrange[600],
                                  height: 5,
                                  thickness: 2.0,
                                  endIndent: 70,
                                ),

                                const SizedBox(height: 5,),
                                  
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(product.category),
                                ),

                                const SizedBox(height: 10,),

                                const Text(
                                  "Product Price",
                                  style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                ),

                                Divider(
                                  color: Colors.deepOrange[600],
                                  height: 5,
                                  thickness: 2.0,
                                  endIndent: 70,
                                ),

                                const SizedBox(height: 5,),
                                  
                                Align(
                                  alignment: Alignment.center,
                                  child: Text("${product.price}"),
                                ),

                                const SizedBox(height: 10,),

                                const Text(
                                  "Product Use",
                                  style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                ),

                                Divider(
                                  color: Colors.deepOrange[600],
                                  height: 5,
                                  thickness: 2.0,
                                  endIndent: 70,
                                ),

                                const SizedBox(height: 5,),
                                  
                                Align(
                                  alignment: Alignment.center,
                                  child: product.used ? const Text('Second Hand'): const Text('Never used'),
                                ),

                                const SizedBox(height: 10,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 5,),

                    Row(
                      children: [
                        const SizedBox(width: 10,),

                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: notifier.getTheme().cardColor,
                              borderRadius: BorderRadius.circular(12)
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 250,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: notifier.getTheme().cardColor,
                                    borderRadius: BorderRadius.circular(12)
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(width: 10,),

                                          Icon(
                                            Icons.phone,
                                            color: Colors.orange[900],
                                          ),

                                          const SizedBox(width: 10,),

                                          const Text(
                                            "Contact Info",
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ]
                                      ),
                                      
                                      const Divider(
                                        height: 3,
                                        thickness: 3,
                                        indent: 40,
                                        endIndent: 20,
                                        color: Colors.grey
                                      ),
                                    ],
                                  )
                                ),

                                Divider(
                                  color: notifier.getTheme().scaffoldBackgroundColor,
                                  height: 8,
                                  thickness: 5.0,
                                ),

                                const SizedBox(height: 5,),

                                seller.profile_image == '' ?
                                  const CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(''),
                                    )
                                  : const CircleAvatar(
                                      radius: 70,
                                      backgroundImage: AssetImage('assets/images/user_profile_icon.png'),
                                    ),

                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "   Name",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  )
                                ),

                                Divider(
                                  color: Colors.orange[900],
                                  height: 5,
                                  thickness: 2.0,
                                  indent: 7,
                                  endIndent: 110,
                                ),

                                const SizedBox(height: 5,),

                                Text(seller.seller_name),
                                
                                const SizedBox(height: 10,),

                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "   Phone Number",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  )
                                ),

                                Divider(
                                  color: Colors.orange[900],
                                  height: 5,
                                  thickness: 2.0,
                                  indent: 7,
                                  endIndent: 55,
                                ),

                                const SizedBox(height: 5,),

                                Text('${seller.seller_number}'),

                                const SizedBox(height: 10,),

                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "   Email",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  )
                                ),

                                Divider(
                                  color: Colors.orange[900],
                                  height: 5,
                                  thickness: 2.0,
                                  indent: 7,
                                  endIndent: 110,
                                ),

                                const SizedBox( height: 5,),

                                Text('${seller.seller_email}'),

                                const SizedBox( height: 10,),

                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "   Calification",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  )
                                ),

                                Divider(
                                  color: Colors.orange[900],
                                  height: 5,
                                  thickness: 2.0,
                                  indent: 7,
                                  endIndent: 70,
                                ),

                                const SizedBox(height: 10,),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 15,),

                        Expanded(
                            child: Column(
                          children: [
                            Container(
                                width: 250,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: notifier.getTheme().cardColor,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                  children: [
                                    Row(children: [
                                      const SizedBox(width: 10,),

                                      Icon(
                                        Icons.phone,
                                        color: Colors.orange[900],
                                      ),

                                      const SizedBox(width: 10,),

                                      const Text(
                                        "Contact Info",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ]),

                                    const Divider(
                                      height: 3,
                                      thickness: 3,
                                      indent: 40,
                                      endIndent: 20,
                                      color: Colors.grey)
                                  ],
                                )),

                            const SizedBox(height: 10,),

                            Container(
                              height: 300,
                              padding: const EdgeInsets.all(11),
                              decoration: BoxDecoration(
                                color: notifier.getTheme().cardColor,
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: Text(product.description),
                            ),

                            const SizedBox(height: 10,),

                            ElevatedButton(
                              onPressed: () {
                                ProductDetailController()
                                  .addProductToCart(product.id);
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.deepOrange)
                              ),
                              child: const Text(
                                'Add to Cart',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ],
                        )),
                        const SizedBox(width: 10,),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
    );
  }
}
