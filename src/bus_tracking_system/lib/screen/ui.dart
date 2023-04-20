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
        centerTitle: true,
        title: Text('BUS TRACKER',),
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
            TextField(
          decoration: InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: Icon(Icons.person)),
        ),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.person),
          ),
          obscureText: true,
        ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('Login', style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 67),
          ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: toggleLoginOption,
              child: Text(isStudent ? 'Log in as Driver' : 'Log in as Student', style: TextStyle(fontSize: 20),),
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
