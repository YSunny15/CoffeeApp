// ignore_for_file: unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud_operations/Services/database.dart';

import '../models/users.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on FirebaseUser
  AppUser? _userFromFirebaseUser(User? user) {
    // ignore: unnecessary_null_comparison
    // return AppUser(uid: user.uid);
    return user != null ? AppUser(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
    // return _auth
    //     .authStateChanges()
    //     .map((Users user) => _userFromFirebaseUser(user));
  }

  //Sign in anony
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      // return user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign in with email-password

  //Register with email-password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      //Create a new doc for the user with uid
      await DatabaseService(uid: user!.uid).updateUserData('0', 'new', 100);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

  //Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
