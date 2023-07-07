import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? onTap;

  const MyButton({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF13A4DD),
            Color(0xFF189FDF),
            Color(0xFF18A0DC),
            Color(0xFF15A9D7),
            Color(0xFF11B1D5),
            Color(0xFF13B7D3),
            Color(0xFF12BFCF),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
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
