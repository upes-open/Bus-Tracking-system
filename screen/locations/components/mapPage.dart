import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';

class MapPage extends StatefulWidget {
  final String location;

  const MapPage({Key? key, required this.location}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final LatLng _center = const LatLng(45.521563, -122.677433);
  late GoogleMapController _controller;
  late Position _currentPosition;
  late DatabaseReference _locationRef;
  late DatabaseReference _databaseRef;
  Marker? _marker;
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _locationRef = FirebaseDatabase.instance.reference().child('location');
    _databaseRef = FirebaseDatabase.instance.reference().child('locations');

    _getCurrentLocation();
    _getLocationData();
  }

  void _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _locationRef.child('user1').set({
          'latitude': _currentPosition.latitude,
          'longitude': _currentPosition.longitude
        });
      });
    }).catchError((e) {
      print(e);
    });
  }

  void _getLocationData() {
    _databaseRef.child('location').onValue.listen((event) {
      if (event.snapshot.value != null) {
        var data = event.snapshot.value as Map<dynamic, dynamic>;
        var latitude = data['latitude'];
        var longitude = data['longitude'];
        if (latitude != null && longitude != null) {
          setState(() {
            _marker = Marker(
              markerId: MarkerId('currentLocation'),
              position: LatLng(latitude, longitude),
            );
            _polylines.add(Polyline(
              polylineId: PolylineId('route1'),
              visible: true,
              points: <LatLng>[
                LatLng(_currentPosition.latitude, _currentPosition.longitude),
                LatLng(latitude, longitude),
              ],
              color: Colors.blue,
              width: 4,
            ));
          });
        }
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.location),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        polylines: _polylines,
      ),
    );
  }
}
