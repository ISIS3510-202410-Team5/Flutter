import 'package:flutter/material.dart';
import 'package:unimarket/Controllers/auth_controller.dart';
import 'package:unimarket/Views/login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  late AuthController _authController;

  String email = "";
  String contrasena = "";
  late bool registroExitoso;
  
  @override
  void initState(){
    _authController = AuthController();
    super.initState();
  }

  void showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.red, // Set background color to red
          title: const Text('Oops!'),
          content: const Text(
              'Something went wrong registering your user. Make sure you are using a valid email format. Make sure your password is at least 6 characters long. Make sure your email is not associated with an existing account'),
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

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.green, // Set background color to green
          title: const Text('Success!'),
          content: const Text('Registration successful! Now please sign in'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginView()));
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

//hace parte del scaffold. ignorar para otras cosas
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
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 206, 190),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const LoginView()));
          },
        ),
        backgroundColor:
            Colors.transparent, // Para hacer transparente la AppBar
        elevation: 0, // Para eliminar la sombra debajo de la AppBar
      ),
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
                            'Register',
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
                            // try {
                            _authController.registrar(email, contrasena).then(
                                (value) => value == null
                                    ? showErrorDialog(context)
                                    : showSuccessDialog(context));
                            // } catch (e) {
                            //   print(e.toString() + "9999999999999999999999");
                            //   showErrorDialog(context);
                            // }

                            // print(registroExitoso);
                            // registroExitoso
                            //     ? showErrorDialog(context)
                            // showErrorDialog(context);
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