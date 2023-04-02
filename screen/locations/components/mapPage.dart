import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  final String location;

  MapPage({required this.location});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Map - $location'),
      ),
      body: Center(
        child: Text('Map of $location'),
      ),
    );
  }
}
