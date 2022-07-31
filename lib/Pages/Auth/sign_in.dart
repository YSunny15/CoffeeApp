import 'package:firebase_crud_operations/Services/auth.dart';
import 'package:flutter/material.dart';

import '../../shared/constant.dart';
import '../../shared/loading.dart';

class SignIn extends StatefulWidget {
  //
  final Function toggleView;
  SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.pink.shade100,
            appBar: AppBar(
              backgroundColor: Colors.pink.shade400,
              elevation: 0.0,
              title: const Text('Sign In for Coffee'),
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
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
            body: Center(
              child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            validator: ((value) =>
                                value!.isEmpty ? 'Enter an email' : null),
                            decoration:
                                textInputdecoration.copyWith(hintText: 'Email'),
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
                            validator: ((value) => value!.length < 8
                                ? 'Enter 8 digit password'
                                : null),
                            decoration: textInputdecoration.copyWith(
                                hintText: 'Password'),
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
                                  dynamic result =
                                      await _auth.registerWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    setState(() {
                                      loading = false;
                                      error = 'Please write a valid email';
                                    });
                                  }
                                }

                                // print(email);
                                // print(password);
                                // print()
                              },
                              icon: const Icon(Icons.login_rounded),
                              label: const Text('SignIn')),
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
                      ))

                  //  ElevatedButton(
                  //     style: ElevatedButton.styleFrom(primary: Colors.pink[600]),
                  //     onPressed: () async {
                  //       dynamic result = await _auth.signInAnon();
                  //       if (result == null) {
                  //         print('error signing in');
                  //       } else {
                  //         print('Signed In');
                  //         print(result.uid!);
                  //       }
                  //     },
                  //     child: const Text('Sign in Anony')),
                  ),
            ),
          );
  }
}
