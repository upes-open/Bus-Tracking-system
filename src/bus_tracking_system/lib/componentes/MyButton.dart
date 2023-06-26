import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? onTab;

  const MyButton({
    Key? key,
    required this.label,
    required this.onTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            //

            //
            Color.fromARGB(255, 74, 162, 216),

            Color.fromARGB(255, 65, 169, 228),
            Color.fromARGB(255, 96, 168, 184),

            // Color.fromARGB(210, 74, 187, 224),
            Color.fromARGB(229, 41, 180, 211),

            // Color(0xFF38B1D0),

            Color(0xFF22CCD1),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: InkWell(
        onTap: onTab,
        borderRadius: BorderRadius.circular(
            30), // Ensure ripple effect matches the button shape
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
