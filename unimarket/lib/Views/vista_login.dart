import 'package:flutter/material.dart';
import 'package:unimarket/Views/body_view.dart';

class VistaLogin extends StatelessWidget {
  const VistaLogin({super.key});

  Widget _buildTextField(String labelText, String hintText,
      {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(
              right: 230, top: 17), // Adjust margin as needed
          child: Text(
            labelText,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    void authenticationProcess(){

      bool existing_user = true;

      // Aquí va el proceso de verificación con Firebase

      if(existing_user){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  BodyView()));
      } 
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 206, 190),
      body: Column(
        children: [
          Container(
            height: 200, // Adjust the height as needed
            color: const Color.fromARGB(
                255, 250, 206, 190), // Example color, change as needed
            child: const Center(
              child: Image(
                image: AssetImage("assets/imagenes/logo.png"),
                height: 100,
                width: 100,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 350,
                margin: const EdgeInsets.only(bottom: 100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 255, 100, 35),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(bottom: 35),
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 36.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        _buildTextField('Email/Username', 'user@example.com'),
                        const SizedBox(height: 20.0),
                        _buildTextField('Password', '******',
                            obscureText: true),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: (){authenticationProcess();},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
