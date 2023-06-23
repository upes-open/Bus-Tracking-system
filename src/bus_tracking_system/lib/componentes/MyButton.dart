// ignore: file_names
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  //final Function()? onTab;

  const MyButton(
      {Key? key,
      required this.label,
      required this.onPressed}) //required this.onTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // onTab: onTab,
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.symmetric(horizontal: 25.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 30, 170, 188),
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        //to make it tabable
        onTap: onPressed,
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
            ),
          ),
        ),
      ),
    );
  }
}
