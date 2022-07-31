import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../models/brew_model.dart';
import 'brew_tile.dart';

class BrewList extends StatefulWidget {
  const BrewList({super.key});

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    //Access data from auth stream
    final brews = Provider.of<List<Brew>?>(context) ?? [];
    // final datas = Provider.of<QuerySnapshot?>(context);
    // print(datas!.docs);
    // for (var doc in datas!.docs) {
    //   print(doc.data());
    // }
    // brews?.forEach(
    //   (data) {
    //     print(data.name);
    //     print(data.sugars);
    //   },
    // );

    return ListView.builder(
        itemCount: brews.length,
        itemBuilder: ((context, index) {
          return BrewTile(brew: brews[index]);
        }));
  }
}
