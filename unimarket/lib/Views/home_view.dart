import 'package:flutter/material.dart';
import 'package:unimarket/Views/search_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  
  void searchSelection(){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  SearchView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: 
        ListView(
          
          children: [
            SizedBox(height: 20,),

            Align(
              alignment: Alignment.center,
              child: Text("Welcome to Unimarket", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),),
            ),
            
            SizedBox(height: 30,),

            SearchBar(
              leading: Icon(Icons.search, color: Colors.black,),
              hintText: "Search something...",
              onTap: () {searchSelection();},
            ),

            SizedBox(height: 20,),

            Text("What are you looking for?", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

            Divider(thickness: 5, color: Colors.grey,),

            SizedBox(height: 40,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.deepOrange, width: 5)
                      ),
                      child: 
                        Column(
                          children: [
                            Icon(Icons.format_paint, size: 65,),
                          ],
                        ),
                    ),
                    Text("Art Materials", style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),

                SizedBox(width: 100,),

                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.deepOrange, width: 5)
                      ),
                      child: 
                        Column(
                          children: [
                            Icon(Icons.camera_rounded, size: 65,),
                          ],
                        ),
                    ),
                    Text("Audiovisuals", style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
              ],
            ),

            SizedBox(height: 60,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.deepOrange, width: 5)
                      ),
                      child: 
                        Column(
                          children: [
                            Icon(Icons.security_rounded, size: 65,),
                          ],
                        ),
                    ),
                    Text("Security", style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),

                SizedBox(width: 100,),

                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.deepOrange, width: 5)
                      ),
                      child: 
                        Column(
                          children: [
                            Icon(Icons.book, size: 65,),
                          ],
                        ),
                    ),
                    Text("Books", style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
              ],
            ),

            SizedBox(height: 60,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.deepOrange, width: 5)
                      ),
                      child: 
                        Column(
                          children: [
                            Icon(Icons.computer_rounded, size: 65,),
                          ],
                        ),
                    ),
                    Text("Hardware", style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),

                
              ],
            ),
          ],
        ),
    );
  }
}
