import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// crear usuario a partir del firebaseuser

User fbUser(FirebaseUser user){
  return user != null? User()
}

}
