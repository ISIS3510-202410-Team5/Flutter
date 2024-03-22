import 'package:flutter/material.dart';
import 'package:unimarket/Model/product_model.dart';


class ProductDetail{

  late ProductModel product;
  late StatelessWidget view;

  ProductDetail(ProductModel prod){
    product = prod;
    view = ProductDetail_view(product);
  }
}

class ProductDetail_view extends StatelessWidget {
  
  late final ProductModel product;

  ProductDetail_view(ProductModel prod){
    product=prod;
  }

  @override
  Widget build(BuildContext context) {

    void addProductToCart(){

    }

    return Scaffold(

      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text("Product Info", style: TextStyle(color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.bold)),
      ),

      body: 
        Expanded(
          child: Column(
            children: [

              SizedBox(height: 8,),

              AppBar(
                leading: Icon(Icons.info, color: Colors.orange[900],),
                title: Text("General Information", style: TextStyle(fontSize: 17),),
                backgroundColor: Colors.white,
                toolbarHeight: 35,
              ),

              Divider(color: Colors.grey[100], height: 8,),

              Container(
                
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: 
                  Row(
                    children: <Widget>[

                      Expanded(
                        child: 
                          Image.network(product.product_image!, height: 200, width: 150,),
                      ),

                      Expanded(
                        child: 
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            
                            children: [
                              Align(
                                alignment:Alignment.topLeft,
                                child:
                                  Text("Product Name", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.left,)
                              ),
                              Divider(color: Colors.orange[700], height: 5, thickness: 2.0,),
                              Text(product.product_name!),
                              SizedBox(height: 10,),
                              
                              Align(
                                alignment:Alignment.topLeft,
                                child:
                                  Text("Product Type", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.left,)
                              ),
                              Divider(color: Colors.orange[700], height: 5, thickness: 2.0,),
                              Text(product.product_category!),
                              SizedBox(height: 10,),

                              Align(
                                alignment:Alignment.topLeft,
                                child:
                                  Text("Price", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.left,)
                              ),
                              Divider(color: Colors.orange[700], height: 5, thickness: 2.0,),
                              Text("\$ ${product.product_price!}"),
                              SizedBox(height: 10,),

                              Align(
                                alignment:Alignment.topLeft,
                                child:
                                  Text("Product Use", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.left,)
                              ),
                              Divider(color: Colors.orange[700], height: 5, thickness: 2.0,),
                              Text(product.product_use!),
                              SizedBox(height: 10,),

                              Divider(color: Colors.grey[100], height: 8,),
                            ],
                          ),
                      ),
                    ],
                  ),
              ),

              SizedBox(height: 20,)
,
              Row(
                children: [
                  SizedBox(width: 10,),
                  Expanded(
                    child: 
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: 
                          Column(
                            children: [
                              AppBar(
                                
                                leading: Icon(Icons.phone, color: Colors.orange[900], ),
                                title: Text("Contact Information", style: TextStyle(fontSize: 17),),
                                backgroundColor: Colors.white,
                                toolbarHeight: 35,
                                
                              ),

                              Divider(color: Colors.grey[100], height: 8, thickness: 5.0,),

                              Icon(Icons.person_pin_outlined, size: 150,),
                              Align(
                                alignment:Alignment.topLeft,
                                child:
                                  Text("Name", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.left,)
                              ),
                              Divider(color: Colors.orange[700], height: 5, thickness: 2.0,),
                              Text("TXT"),
                              SizedBox(height: 10,),

                              Align(
                                alignment:Alignment.topLeft,
                                child:
                                  Text("Phone Number", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.left,)
                              ),
                              Divider(color: Colors.orange[700], height: 5, thickness: 2.0,),
                              Text("TXT"),
                              SizedBox(height: 10,),

                              Align(
                                alignment:Alignment.topLeft,
                                child:
                                  Text("Email", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.left,)
                              ),
                              Divider(color: Colors.orange[700], height: 5, thickness: 2.0,),
                              Text("TXT"),
                              SizedBox(height: 10,),

                              Align(
                                alignment:Alignment.topLeft,
                                child:
                                  Text("Calification", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.left,)
                              ),
                              Divider(color: Colors.orange[700], height: 5, thickness: 2.0,),
                              
                              SizedBox(height: 10,),
                            ],
                          ),
                      )
                  ),
                  SizedBox(height: 20, width: 13,),
                  Expanded(
                    child: 
                      Column(
                        children: [
                          Container(
                            color: Colors.white,
                            child: 
                              Column(
                                
                                children: [
                                  AppBar(
                                    leading: Icon(Icons.text_snippet_outlined, color: Colors.orange[900],),
                                    title: Text("Description", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                                    backgroundColor: Colors.white,
                                    toolbarHeight: 35,
                                  ),

                                  Divider(color: Colors.grey[100], height: 8, thickness: 10.0,),

                                  Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Montes nascetur ridiculus mus mauris vitae ultricies leo integer. Quis lectus nulla at volutpat diam ut venenatis. Velit laoreet id donec ultrices tincidunt. Tempor nec feugiat nisl pretium. Enim ut tellus elementum sagittis vitae et leo. Tellus mauris a diam maecenas sed. Viverra nam libero justo laoreet sit amet. Leo integer malesuada nunc vel risus commodo. Vel elit scelerisque mauris pellentesque pulvinar."),

                                  Divider(color: Colors.grey[100], height: 8, thickness: 10.0,),

                                  
                                ],
                              ),
                          ),
                          ElevatedButton(onPressed: (){addProductToCart();}, child: const Text('Add to Cart', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), style: ButtonStyle(),),
                      ],
                    )
                  ),
                ],
              ),
            ],
          ),),

    );
  }
}

