import 'package:bus_tracking_system/helper/helperFunction.dart';
import 'package:bus_tracking_system/services/authServices.dart';
import 'package:bus_tracking_system/services/databaseServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:bus_tracking_system/screen/locations/locations_page.dart';
=======
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
>>>>>>> 1539f06958eafa40aa369b40ee2ddb279aabf01b


class UI extends StatefulWidget {//is a 
  @override
  _UIState createState() => _UIState();
}

class _UIState extends State<UI> {
  AuthService _auth = AuthService()
  
  
  bool isStudent = true;
  late final String email;
  late final String password;

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
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {//set management
                    email = value;
                  });
                }),
            SizedBox(height: 10),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
<<<<<<< HEAD
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return LocationsPage();
                },),);
=======
               login();
>>>>>>> 1539f06958eafa40aa369b40ee2ddb279aabf01b
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('password', password));
  }

  login() async{
    await _auth.loginWithUserEmailandPassword(email, password).then((value) async{//auth services instance
      if(value==true){
        QuerySnapshot snapshot= await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).getUserData( email) ;
    //sharedrefences
    await HelperFunctions.savedUserLoggedInStatus(true);
    await HelperFunctions.savedUserEmailSF(email);
    //await HelperFunctions.getUserNamefromSF(true);
   /* Navigator.push(context,MaterialPageRoute(builder:(context) {
      homepage
    }))*/


      }
    });//
    

  }
}
