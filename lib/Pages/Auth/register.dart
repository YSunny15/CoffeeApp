import 'package:firebase_crud_operations/shared/constant.dart';
import 'package:firebase_crud_operations/shared/loading.dart';
import 'package:flutter/material.dart';

import '../../Services/auth.dart';

class Register extends StatefulWidget {
  //
  final Function toggleView;
  Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Text Field state
  String email = '';
  String password = '';
  String error = '';

  //
  final AuthService _auth = AuthService();
  // Used to identify form
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  //
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.pink.shade100,
      appBar: AppBar(
          backgroundColor: Colors.pink.shade400,
          elevation: 0.0,
          title: const Text('Sign Up for Coffee'),
          actions: [
            TextButton.icon(
                onPressed: () {
                  widget.toggleView();
                },
                icon: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                label: const Text(
                  'SignIn',
                  style: TextStyle(color: Colors.white),
                ))
          ]),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  //Validator function to check
                  // Mtlb agr kisi ne mail wla box khali choda th error dega jaise ki email*
                  validator: ((value) =>
                      value!.isEmpty ? 'Enter an email' : null),
                  decoration: textInputdecoration.copyWith(hintText: 'Email'),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  decoration:
                      textInputdecoration.copyWith(hintText: 'Password'),
                  validator: ((value) =>
                      value!.length < 8 ? 'Enter 8 digit password' : null),
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                TextButton.icon(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() => loading = true);
                        dynamic result = await _auth
                            .registerWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() {
                            loading = false;
                            error = 'Please write a valid email';
                          });
                        }
                      }
                    },
                    icon: const Icon(Icons.login_rounded),
                    label: const Text('Register')),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  error,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 15),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
