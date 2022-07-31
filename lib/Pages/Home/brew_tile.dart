import 'package:flutter/material.dart';

import 'package:firebase_crud_operations/models/brew_model.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;
  const BrewTile({
    Key? key,
    required this.brew,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: const AssetImage(
              'Assets/3.png',
            ),
            radius: 25,
            backgroundColor: Colors.brown[brew.strength],
          ),
          title: Text(brew.name),
          subtitle: Text('Take ${brew.sugars} sugar(s)'),
        ),
      ),
    );
  }
}
