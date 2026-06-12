
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  static AuthService instance = AuthService._init();
  AuthService._init();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    User? currentUser = await firebaseAuth.currentUser;
    return currentUser;
  }

  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async{
    UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async{
    UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  Future<void> logout() async {
    firebaseAuth.signOut();
  }
}