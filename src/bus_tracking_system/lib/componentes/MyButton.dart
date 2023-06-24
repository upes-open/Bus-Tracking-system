// ignore: file_names
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  // final VoidCallback onPressed;
  final Function()? onTab;

  const MyButton(
      {Key? key,
      required this.label,
      required this.onTab}) //required this.onTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // onTab: onTab,

      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 30, 170, 188),
        borderRadius: BorderRadius.circular(30),
      ),
      child: InkWell(
        onTap: onTab,

        //to make it tabable

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
