import 'dart:async';
import 'dart:convert';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../Constants/constants.dart';
import 'package:bus_tracking_system/screen/profile.dart';
import 'package:bus_tracking_system/screen/locations_page.dart';
import 'package:bus_tracking_system/screen/DriverLoginPage.dart';

class BusTracking extends StatefulWidget {
  @override
  _BusTrackingState createState() => _BusTrackingState();
}

// class Destination extends StatefulWidget {
//   final double destinationLatitude;
//   final double destinationLongitude;

//   Destination({
//     required this.destinationLatitude,
//     required this.destinationLongitude,
//   });
//   // const Destination({Key? key}) : super(key: key);

//   @override
//   State<Destination> createState() => _RealTimeDestLocation();
// }
// Retirieving Destination Location

// class _RealTimeDestLocation extends State<Destination> {
//   final ref = FirebaseDatabase.instance.ref('DestinationLocation');

//   double latitude = 0;
//   double longitude = 0;

//   @override
//   void initState() {
//     super.initState();
//     ref.onValue.listen((event) {
//       final DataSnapshot snapshot = event.snapshot; // Access the DataSnapshot
//       final destinationLocationData = snapshot.value as Map<dynamic, dynamic>?;

//       print(
//           "Destination Location Data: $destinationLocationData"); // Debugging line

//       if (destinationLocationData != null) {
//         setState(() {
//           latitude = destinationLocationData['Latitude'] as double;
//           longitude = destinationLocationData['Longitude'] as double;
//         });

//         if (latitude != null && longitude != null) {
//           print("Latitude: $latitude, Longitude: $longitude");
//           // Use latitude and longitude values here
//         }
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       children: [Text(latitude.toString())
//       , Text(longitude.toString())],
//     )); // Empty widget, no UI elements
//   }
// }

class _BusTrackingState extends State<BusTracking> {
  String apiKey = orsapikey; //OpenRouteService API key
  late String distance = '';
  late String time = '';
  bool isLoading = false; //A flag to check the status of the api data loading
  late LatLng sourceLocation = LatLng(0, 0); //For user location
  // late LatLng destinationLocation = LatLng(30.3253,
  //     78.0413); //Destination Location (retrieved from the firebase database; must be connected to firebase)
  late LatLng destinationLocation = LatLng(0, 0);
  // double destinationLatitude = 0; // Initialize with default value
  // double destinationLongitude = 0; // Initialize with default value
  List<LatLng> polylinePoints = [];
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  late DatabaseReference dbRef;
  // Query dbRef2 = FirebaseDatabase.instance.ref().child('DestinationLocation');

  @override
  void initState() {
    super.initState();
    // dbRef2.once().then((snapshot){
    //   if (snapshot.value != null) {
    //     final destinationLocationData = snapshot.value as Map<dynamic, dynamic>?;
    //     if (destinationLocationData != null) {
    //       final latitude = destinationLocationData['Latitude'] as double?;
    //       final longitude = destinationLocationData['Longitude'] as double?;
    //       if (latitude != null && longitude != null) {
    //         setState(() {
    //           destinationLatitude = latitude;
    //           destinationLongitude = longitude;
    //         });
    //       }
    //     }
    //   }
    // });
    // Initialize Firebase Database reference
    try{
      final dbReference = FirebaseDatabase.instance.ref().child('DestinationLocation');
      dbReference.once().then((DatabaseEvent databaseEvent) {
        if (databaseEvent.snapshot.value != null) {
          final destinationLocationData = databaseEvent.snapshot.value as Map<dynamic, dynamic>;
          final latitude = destinationLocationData['latitude'] as double?;
          final longitude = destinationLocationData['longitude'] as double?;
          print(latitude);
          print(longitude);

          if (latitude != null && longitude != null) {
            setState(() {
              destinationLocation = LatLng(latitude, longitude);
            });
          }
        }
      });
    }
    catch (e) {
      throw Exception("Error accessing Firebase Database");
    }

    dbRef = FirebaseDatabase.instance.ref().child('Value');
    initNotifications();
    requestPermission();
  }
  // dbRef.onValue.listen((event) {
  //   if (event.snapshot.value != null) {
  //     final locationString = event.snapshot.value as String;
  //     final regex = RegExp(r'LatLng\(latitude:(.*), longitude:(.*)\)');
  //     final match = regex.firstMatch(locationString);
  //     if (match != null && match.groupCount == 2) {
  //       final latitude = double.parse(match.group(1)!);
  //       final longitude = double.parse(match.group(2)!);
  //       print("Latitude: $latitude, Longitude: $longitude");
  //       setState(() {
  //         destinationLocation = LatLng(latitude, longitude);
  //       });
  //     }
  //   }
  // });

//Permission to access live-location
  Future<void> requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
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
    } else if (permission == LocationPermission.deniedForever) {
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

  //Extraction of Live-location
  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      sourceLocation = LatLng(position.latitude, position.longitude);
    });
    fetchPolyline(sourceLocation, destinationLocation).then((points) {
      setState(() {
        polylinePoints = points;
      });
    });
  }

  //Time format
  String formatTime(double duration) {
    if (duration >= 60) {
      int hours = duration ~/ 60;
      int minutes = (duration % 60).toInt();
      return '${hours}h ${minutes}m';
    } else {
      return '${duration.round()}min';
    }
  }

  //Notification Alert for Bus_Arrival
  Future<void> initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'bus_arrival_channel',
      'Bus Arrival',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Bus is about to reach',
      'The bus will arrive within 2 minutes.',
      platformChannelSpecifics,
    );
  }

  //Calculate distance and time through an API request using OpenRouteService API
  Future<void> calculateDistanceAndTime() async {
    setState(() {
      isLoading = true;
    });

    String url =
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=${sourceLocation.longitude},${sourceLocation.latitude}&end=${destinationLocation.longitude},${destinationLocation.latitude}';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final route = jsonResponse['features'][0]['properties'];
        setState(() {
          distance =
              (route['segments'][0]['distance'] / 1000).toStringAsFixed(2) +
                  "km";
          double duration = (route['segments'][0]['duration'] / 60);
          time = formatTime(duration);
        });
        //This will display an alert that the bus is near
        // if (double.parse(time) <= 2) {
        //   showNotification();
        // }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  //Fetching polylines points via the ORS API
  Future<List<LatLng>> fetchPolyline(LatLng source, LatLng destination) async {
    final response = await http.get(Uri.parse(
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=${source.longitude},${source.latitude}&end=${destination.longitude},${destination.latitude}'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final coordinates =
          jsonResponse['features'][0]['geometry']['coordinates'];
      return coordinates
          .map<LatLng>((coord) => LatLng(coord[1], coord[0]))
          .toList();
    } else {
      throw Exception('Failed to load polyline');
    }
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Do you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                // Perform logout operation
                Navigator.of(context).pop();
                // Add your logout logic here
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDistanceTimeVisible = distance.isNotEmpty && time.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Select Route',
          style: TextStyle(color: Colors.black),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              color: Colors.black,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Select Route'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LocationsPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: _showLogoutConfirmationDialog,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(destinationLocation.latitude, destinationLocation.longitude),
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
                      width: 30.0,
                      height: 30.0,
                      point: sourceLocation,
                      builder: (ctx) => Container(
                        child: Image.asset(
                          'assets/images/person.png', //Custom Person icon
                          width: 5.0,
                          height: 5.0,
                        ),
                      ),
                    ),
                    Marker(
                      width: 35.0,
                      height: 35.0,
                      point: LatLng(destinationLocation.latitude, destinationLocation.longitude),
                      builder: (ctx) => Container(
                        child: Image.asset(
                          'assets/images/busicon.png', //Custom Bus icon
                          width: 5.0,
                          height: 5.0,
                        ),
                      ),
                    ),
                  ],
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: polylinePoints,
                      strokeWidth: 4.0,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
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
                Text(
                  'Latitude: ${destinationLocation.latitude}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Longitude: ${destinationLocation.longitude}',
                  style: TextStyle(fontSize: 16),
                ),
                if (!isDistanceTimeVisible)
                  // calculateDistanceAndTime();isLoading ? null : calculateDistanceAndTime,
                  ElevatedButton(
                    onPressed: () {
                      
                      isLoading
                          ? null
                          : calculateDistanceAndTime().then((value) {
                              Map<String, String> values = {
                                'Distance': distance,
                                'Time': time,
                                'sourceLocation': sourceLocation.toString(),
                                'destinationLocation':
                                    destinationLocation.toString(),
                              };
                              dbRef.push().set(values);
                            });
                    },
                    child: Text('Show Distance & Time'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.grey;
                          }
                          return Colors
                              .blue; //when ORS api data fetching is successful and it is ready to show required data(distance and time)
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
