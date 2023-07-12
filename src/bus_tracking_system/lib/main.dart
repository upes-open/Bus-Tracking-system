import 'package:flutter/material.dart';
// import 'package:prometheus_client/prometheus_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bus_tracking_system/screen/splash.dart';
import 'package:bus_tracking_system/screen/ui.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // initialize app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //final counterMetric = CounterMetric(name: ‘my_app_counter’);
  // initialize Firebase
  //counterMetric.inc();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  runApp(MyApp()); // run app
}

// CounterMetric({required name}) {
//   return null;
// }

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
