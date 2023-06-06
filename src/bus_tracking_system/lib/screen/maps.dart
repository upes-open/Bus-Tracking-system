import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class Bus_tracking extends StatefulWidget {
  const Bus_tracking({Key? key}) : super(key: key);

  @override
  _BustrackingState createState() => _BustrackingState();
}

class _BustrackingState extends State<Bus_tracking> {
  LatLng _currentLocation = LatLng(0, 0); //Source Location
  LatLng _destinationLocation = LatLng(
      30.4159, 77.9668); //Destination Location(must be connected to firebase)
  MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _mapController.move(_currentLocation, 15.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Map Demo'),
      ),
      body: _currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                center: _currentLocation,
                zoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _currentLocation,
                      builder: (ctx) => Container(
                        child: Icon(
                          Icons.location_on,
                          color: Colors.green,
                          size: 40.0,
                        ),
                      ),
                    ),
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _destinationLocation,
                      builder: (ctx) => Container(
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40.0,
                        ),
                      ),
                    ),
                  ],
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: [_currentLocation, _destinationLocation],
                      color: Colors.blue,
                      strokeWidth: 4.0,
                    ),
                  ],
                ),
              ],
              mapController: _mapController,
            ),
    );
  }
}
