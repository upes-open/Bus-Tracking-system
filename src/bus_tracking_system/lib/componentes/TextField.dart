// ignore: file_names
import "package:flutter/material.dart";

class TextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  const TextField(
      {super.key,
      required InputDecoration decoration,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 30, 170, 188)),
            //borderRadius: BorderRadius.all(18 as Radius)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          fillColor: Color.fromARGB(255, 228, 221, 221),
          filled: true,
        ),
      ),
    );
  }
}
