import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud_operations/models/users.dart';
import 'package:firebase_crud_operations/shared/constant.dart';
import 'package:firebase_crud_operations/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../Services/database.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  //
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  //form values (to keep the track of form values)
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'Update brew settings.',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: userData!.name,
                      decoration: textInputdecoration,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a name' : null,
                      onChanged: (value) =>
                          setState(() => _currentName = value),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //dropdown
                    DropdownButtonFormField(
                        decoration: textInputdecoration,
                        value: _currentSugars ?? userData.sugars,
                        items: sugars.map((sugar) {
                          return DropdownMenuItem(
                              value: sugar, child: Text('$sugar sugars'));
                        }).toList(),
                        onChanged: ((value) =>
                            setState(() => _currentSugars = value))),
                    //slider
                    Slider(
                        min: 100.0,
                        max: 900.0,
                        activeColor:
                            Colors.brown[_currentStrength ?? userData.strength],
                        inactiveColor:
                            Colors.brown[_currentStrength ?? userData.strength],
                        divisions: 8,
                        value:
                            (_currentStrength ?? userData.strength).toDouble(),
                        onChanged: (value) =>
                            setState(() => _currentStrength = value.round())),
                    ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: Colors.pink[400]),
                        onPressed: (() async {
                          if (_formKey.currentState!.validate()) {
                            await DatabaseService(uid: user.uid).updateUserData(
                                _currentSugars ?? userData.sugars,
                                _currentName ?? userData.name,
                                _currentStrength ?? userData.strength);
                            Navigator.pop(context);
                          } 
                        }),
                        child: const Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ));
          } else {
            return Loading();
          }
        }
        //
        );
  }
}
