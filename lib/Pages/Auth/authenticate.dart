import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud_operations/Pages/Auth/register.dart';
import 'package:firebase_crud_operations/Pages/Auth/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  //
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
      print(showSignIn);
    });
  }

  //
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Register(toggleView: toggleView);
    } else {
      return SignIn(toggleView: toggleView);
    }
  }
}
