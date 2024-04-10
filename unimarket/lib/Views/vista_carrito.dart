import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment Details',
      home: PaymentDetailsPage(),
    );
  }
}

class VistaCarrito extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CAR DETAIL'),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Your Cards',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            // Insert here the logos of Visa, MasterCard, etc.
            TextFormField(
              decoration: InputDecoration(labelText: 'Name on Card'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Card Number'),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Expiration Date'),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'CVV'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              child: Text('Pay Now'),
              onPressed: () {
                // Implement payment logic
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          
        ],
      ),
    );
  }
}
