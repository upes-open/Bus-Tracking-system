import 'package:flutter/';
import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const Mybutton({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
        style: ElevatedButton.styleFrom(
          primary: Color.fromARGB(255, 30, 170, 188),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
