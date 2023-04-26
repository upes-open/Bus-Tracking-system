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
  locationonmap1() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double s1 = position.latitude;
    return s1;
  }

  locationonmap2() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double s2 = position.longitude;
    return s2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              Flexible(
                child: FlutterMap(
                  options: MapOptions(
                      center: LatLng(30.4159, 77.9668),
                      zoom: 13),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(30.4159, 77.9668),
                          width: 80,
                          height: 80,
                          builder: (context) => Icon(Icons.pin_drop),
                        ),
                      ],
                    ),
                    PolylineLayer(
                      polylineCulling: true,
                      polylines: [
                        Polyline(
                          points: [
                            LatLng(30.4159, 77.9668),
                            LatLng(30.289189, 77.998667),
                          ],
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
