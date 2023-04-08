import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bus_tracking_system/screen/locations/locations_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'Bus Tracking App',
    home: LocationsPage(),
  ));
}
