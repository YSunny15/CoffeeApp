import 'package:flutter/material.dart';

InputDecoration textInputdecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide:
          BorderSide(width: 2.0, color: Color.fromARGB(255, 247, 228, 234))),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: Colors.pink.shade100)),
  // hintText: "name@domain.com",
  hintStyle: TextStyle(color: Colors.pink[50], fontWeight: FontWeight.w500),
  hintTextDirection: TextDirection.ltr,
  // label: const Text('E-mail',
  //     style: TextStyle(
  //         color: Colors.pink, fontSize: 20, fontWeight: FontWeight.w500)),
);
