import 'dart:convert';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../Constants/constants.dart';
import 'package:bus_tracking_system/screen/profile.dart';
import 'package:bus_tracking_system/screen/locations_page.dart';
class BusTracking extends StatefulWidget {
  @override
  _BusTrackingState createState() => _BusTrackingState();
}

class _BusTrackingState extends State<BusTracking> {
  // Rest of your code...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterMap(
          options: MapOptions(
            center: LatLng(30.4159, 77.9668),
            zoom: 13,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  point: LatLng(30.4159, 77.9668),
                  width: 80,
                  height: 80,
                  builder: (context) => Icon(Icons.pin_drop),
                ),
              ],
            ),
            PolylineLayerOptions(
              polylines: [
                Polyline(
                  points: polylinePoints,
                  strokeWidth: 4.0,
                  color: Colors.blue,
                ),
              ],
            ),
            // Add more layers if needed
          ],
          children: [
            // Add other widgets as children of FlutterMap here

            // Your distance and time display widgets here
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Distance: $distance',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Time: $time',
                    style: TextStyle(fontSize: 16),
                  ),
                  if (!isDistanceTimeVisible)
                    ElevatedButton(
                      onPressed: isLoading ? null : calculateDistanceAndTime,
                      child: Text('Show Distance & Time'),
                      style: ElevatedButton.styleFrom(
                        primary: isLoading ? Colors.grey : Colors.blue,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
