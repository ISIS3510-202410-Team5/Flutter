import 'package:flutter/material.dart';
import 'package:unimarket/Model/product_model.dart';

class ProductDetail {
  late ProductModel product;
  late StatelessWidget view;

  ProductDetail(ProductModel prod) {
    product = prod;
    view = ProductDetail_view(product);
  }
}

class ProductDetail_view extends StatelessWidget {
  late final ProductModel product;

  ProductDetail_view(ProductModel prod) {
    product = prod;
  }

  @override
  Widget build(BuildContext context) {
    void addProductToCart() {}

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
            centerTitle: false,
            backgroundColor: Colors.white,
            title: Column(
              children: [
                Text("Product Info",
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
            )),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                      width: 250,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          Row(children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.info,
                              color: Colors.orange[900],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "General Information",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ]),
                          Divider(
                              height: 3,
                              thickness: 3,
                              indent: 46,
                              endIndent: 20,
                              color: Colors.grey)
                        ],
                      )),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: EdgeInsets.all(11.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Image.network(
                            product.image!,
                            height: 200,
                            width: 150,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Product Name",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  )),
                              Divider(
                                color: Colors.orange[700],
                                height: 5,
                                thickness: 2.0,
                                endIndent: 70,
                              ),
                              Text(product.name!),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Product Type",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  )),
                              Divider(
                                color: Colors.orange[700],
                                height: 5,
                                thickness: 2.0,
                                endIndent: 80,
                              ),
                              Text(product.category!),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Price",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  )),
                              Divider(
                                color: Colors.orange[700],
                                height: 5,
                                thickness: 2.0,
                                endIndent: 135,
                              ),
                              Text("\$ ${product.price!}"),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Product Use",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  )),
                              Divider(
                                color: Colors.orange[700],
                                height: 5,
                                thickness: 2.0,
                                endIndent: 85,
                              ),
                              Text(product.used!.toString()),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: Colors.grey[100],
                                height: 8,
                                thickness: 2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          children: [
                            Container(
                                width: 250,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                  children: [
                                    Row(children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.phone,
                                        color: Colors.orange[900],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Contact Info",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ]),
                                    Divider(
                                        height: 3,
                                        thickness: 3,
                                        indent: 40,
                                        endIndent: 20,
                                        color: Colors.grey)
                                  ],
                                )),
                            Divider(
                              color: Colors.grey[100],
                              height: 8,
                              thickness: 5.0,
                            ),
                            Icon(
                              Icons.person_pin_outlined,
                              size: 150,
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Name",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                )),
                            Divider(
                              color: Colors.orange[700],
                              height: 5,
                              thickness: 2.0,
                              endIndent: 130,
                            ),
                            Text("TXT"),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Phone Number",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                )),
                            Divider(
                              color: Colors.orange[700],
                              height: 5,
                              thickness: 2.0,
                              endIndent: 70,
                            ),
                            Text("TXT"),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Email",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                )),
                            Divider(
                              color: Colors.orange[700],
                              height: 5,
                              thickness: 2.0,
                              endIndent: 135,
                            ),
                            Text("TXT"),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Calification",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                )),
                            Divider(
                              color: Colors.orange[700],
                              height: 5,
                              thickness: 2.0,
                              endIndent: 90,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      )),
                      SizedBox(
                        height: 2,
                        width: 13,
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          Container(
                              width: 250,
                              height: 35,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                children: [
                                  Row(children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.phone,
                                      color: Colors.orange[900],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Contact Info",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ]),
                                  Divider(
                                      height: 3,
                                      thickness: 3,
                                      indent: 40,
                                      endIndent: 20,
                                      color: Colors.grey)
                                ],
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Montes nascetur ridiculus mus mauris vitae ultricies leo integer. Quis lectus nulla at volutpat diam ut venenatis. Velit laoreet id donec ultrices tincidunt. Tempor nec feugiat nisl pretium. Enim ut tellus elementum."),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              addProductToCart();
                            },
                            child: const Text(
                              'Add to Cart',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.deepOrange)),
                          ),
                        ],
                      )),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
