import 'package:firebase_crud_operations/Pages/Auth/authenticate.dart';
import 'package:firebase_crud_operations/Pages/Home/homepage.dart';
import 'package:firebase_crud_operations/models/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    print(user);

    //Return either home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return HomePage();
    }
  }
}
