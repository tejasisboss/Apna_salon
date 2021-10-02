import 'package:flutter/material.dart';

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.black54),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)));
}

Widget addbutton() {
  return Align(
    child: FloatingActionButton(
      mini: true,
      onPressed: () {
        // Add your onPressed code here!
      },
      splashColor: Colors.white,
      child: const Icon(Icons.add),
      backgroundColor: Colors.white54,
    ),
    alignment: Alignment.bottomCenter,
  );
}
