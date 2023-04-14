import 'package:flutter/material.dart';
import 'package:bus_tracking_system/screen/locations/locations_page.dart';

class UI extends StatefulWidget {
  @override
  _UIState createState() => _UIState();
}

class _UIState extends State<UI> {
  bool isStudent = true;

  void toggleLoginOption() {
    setState(() {
      isStudent = !isStudent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BUS TRACKER'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isStudent ? 'STUDENT LOGIN' : 'DRIVER LOGIN',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return LocationsPage();
                },),);
              },
              child: Text('Log In'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: toggleLoginOption,
              child: Text(isStudent ? 'Log in as Driver' : 'Log in as Student'),
            ),
          ],
        ),
      ),
    );
  }
}
