import 'package:flutter/material.dart';
import 'package:prometheus_client/prometheus_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bus_tracking_system/screen/splash.dart';
import 'package:bus_tracking_system/screen/ui.dart';

final counterMetric = Counter('my_app_counter', 'Description of the counter.');

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // initialize app
  await Firebase.initializeApp();
    final counterMetric = Counter('my_app_counter', 'Description of the counter.');
 // initialize Firebase
  counterMetric.inc();
  runApp(MyApp()); // run app
}

void main() {
  // Increment the counter somewhere in your code
  counterMetric.inc();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: splash(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isStudent = true;

  void toggleLoginOption() {
    setState(() {
      isStudent = !isStudent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return UI();
  }
}
