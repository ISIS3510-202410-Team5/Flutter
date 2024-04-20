import 'package:flutter/material.dart';
import 'package:unimarket/Controllers/auth_controller.dart';
import 'package:unimarket/Views/register_view.dart';
import 'package:unimarket/Views/body_view.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  late AuthController _authController;

  String email = "";
  String contrasena = "";
  
  @override
  void initState(){
    _authController = AuthController();
    super.initState();
  }

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
        TextFormField(
          onChanged: (val) {
            setState(() => email = val);
          },
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

  Widget _buildTextField1(String labelText, String hintText,
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
        TextFormField(
          onChanged: (val) {
            setState(() => contrasena = val);
          },
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

  void showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.red, // Set background color to red
          title: const Text('Oops!'),
          content: const Text(
              'Something went wrong singing in. Make sure the credentials you are providing are correct and that you already have an account registered'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    void authenticationProcess(bool existingUser) {
      // Aquí va el proceso de verificación con Firebase

      if (existingUser) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const BodyView()));
      } else {
        showErrorDialog(context);
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
                height: 550,
                // margin: const EdgeInsets.only(bottom: 100),
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
                        _buildTextField1('Password', '******',
                            obscureText: true),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () async {
                            authenticationProcess(await _authController.ingresar(email, contrasena));
                          },
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
                        const SizedBox(
                            height:
                                20.0), // Add some space between the Sign in button and Register button
                        ElevatedButton(
                          onPressed: () {
                            // Add your registration logic here
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RegisterView()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Register',
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

