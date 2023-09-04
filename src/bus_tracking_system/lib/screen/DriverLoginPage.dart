import 'dart:convert';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../Constants/constants.dart';
import 'package:bus_tracking_system/screen/profile.dart';
import 'package:bus_tracking_system/screen/locations_page.dart';

class DriverLoginPage extends StatefulWidget {
  @override
  _DriverLoginPageState createState() => _DriverLoginPageState();
}

class _DriverLoginPageState extends State<DriverLoginPage> {
  final isLoading = false;
  LatLng DestinationLocation = LatLng(0, 0); // Initialize with default values
  // late LatLng destinationLocation = LatLng(
  //     30.3253, //For driver location
  //     78.0413);
  List<LatLng> polylinePoints = []; // Initialize with an empty list
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    requestPermission();

    dbRef = FirebaseDatabase.instance.ref().child('DestinationLocation');
  }

  Future<void> requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Location Permission Required'),
          content:
              Text('This app needs to access your location to work properly.'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Settings'),
              onPressed: () => AppSettings.openAppSettings(),
            ),
          ],
        ),
      );
    } else {
      getCurrentLocation();
    }
  }

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      DestinationLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            isLoading
                ? null
                : requestPermission().then((value) {
                    Map<String, double> values = {
                      'latitude': DestinationLocation.latitude,
                      'longitude': DestinationLocation.longitude,
                    };
                    dbRef.push().set(values);
                  });
          },
          child: Text("Request Location Permission"),
        ),
      ),
    );
  }
}
