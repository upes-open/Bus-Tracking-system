import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const CustomTextField({
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 30, 170, 188)),
            borderRadius: BorderRadius.circular(50),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(50),
          ),
          fillColor: Color.fromARGB(255, 85, 145, 165),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color.fromARGB(255, 140, 173, 177),
          ),
        ),
      ),
    );
  }
}
