import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud_operations/Pages/Home/brew_list.dart';
import 'package:firebase_crud_operations/Pages/Home/setting_.dart';
import 'package:firebase_crud_operations/Services/auth.dart';
import 'package:firebase_crud_operations/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/brew_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: ((context) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SettingsForm(),
            );
          }));
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService().brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          // primary: true,
          backgroundColor: Colors.brown[400],
          title: const Text('Coffee'),
          elevation: 0.0,
          actions: [
            TextButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: const Icon(
                  Icons.logout_rounded,
                  color: Colors.white,
                ),
                label: const Text(
                  'LogOut',
                  style: TextStyle(color: Colors.white),
                )),
            IconButton(
                onPressed: (() => _showSettingsPanel()),
                icon: const Icon(Icons.edit))
          ],
        ),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('Assets/bg.jpg'), fit: BoxFit.cover)),
            child: BrewList()),
      ),
    );
  }
}
