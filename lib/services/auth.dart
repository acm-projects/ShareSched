// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:myapp/models/user.dart';


// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
  
//   User? _userFromFirebaseUser(User? user) {
//     return user != null ? User(uid: user.uid) : null;
//   }
// // User _userFromFirebaseUser(FirebaseUser user) {
// //   return user != null ? User(uid: user.uid) : null;
// // }

  


// //register with email and password
// Future registerWithEmailAndPassword(String email, String password) async {
//   try{
//     UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
//        User? user = result.user;
//       return _userFromFirebaseUser(user);
//   }catch(e){
//     print(e.toString());
//     return null;
//   }
// }

// //Sign in with email and password
// Future signInWithEmailAndPassword(String email, String password) async {
//   try{
//     UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
//        User? user = result.user;
//       return _userFromFirebaseUser(user);
//   }catch(e){
//     print(e.toString());
//     return null;
//   }
// }
// }
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:myapp/models/user.dart';

class AuthService {
  final FirebaseAuth.FirebaseAuth _auth = FirebaseAuth.FirebaseAuth.instance;

  User? _userFromFirebaseUser(FirebaseAuth.User? user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // Register with email and password
  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    try {
      FirebaseAuth.UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseAuth.User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      FirebaseAuth.UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseAuth.User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}


