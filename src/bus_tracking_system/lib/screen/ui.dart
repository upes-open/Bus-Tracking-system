import 'dart:math';
import 'package:bus_tracking_system/Constants/constants.dart';
import 'package:bus_tracking_system/helper/helperFunction.dart';
import 'package:bus_tracking_system/screen/splash.dart';
import 'package:bus_tracking_system/services/authServices.dart';
import 'package:bus_tracking_system/services/databaseServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bus_tracking_system/screen/locations_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

class UI extends StatefulWidget {
  //is a
  @override
  State<UI> createState() => _UIState();
}

class _UIState extends State<UI> {
  AuthService _auth = AuthService();
  bool isStudent = true;
  late final String email;
  late final String password;
  final _formfield = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool passToggle = true;

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
        title: Text(
          'BUS TRACKER',
        ),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color(0x6645b6fe),
                    Color(0x9945b6fe),
                    Color(0xcc45b6fe),
                    Color(0xff45b6fe),
                  ])),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                child: Form(
                    key: _formfield,
                    child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          /*Text(
                    /*isStudent ? "" : "",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                    ),*/
                  ),*/

                          SizedBox(height: 100),

                          /* var  border = OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18)
                              borderSide: const BorderSide(color: Colors.white)
                          )*/

                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: isStudent
                                  ? " Student@domain"
                                  : "driver@email",
                              focusColor: Colors.white12,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              prefixIcon: const Icon(Icons.email),
                            ),
                            validator: (value) {
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!);

                              if (value.isEmpty) {
                                return "Enter Email";
                              } else if (!emailValid) {
                                return "Enter valid Email";
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: passController,
                            obscureText: passToggle,
                            decoration: InputDecoration(
                              labelText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      passToggle = !passToggle;
                                    });
                                  },
                                  child: Icon(passToggle
                                      ? Icons.visibility_off
                                      : Icons.visibility)),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Password';
                              } else if (passController.text.length < 9) {
                                return "Password length should be more than 9 characters";
                              }
                            },
                          ),
                          SizedBox(height: 50),
                          InkWell(
                            onTap: () {
                              if (_formfield.currentState!.validate()) {
                                print("Login Successful");
                                emailController.clear();
                                passController.clear();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return LocationsPage();
                                    },
                                  ),
                                );
                              }
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextButton(
                            onPressed: toggleLoginOption,
                            child: Text(
                              isStudent
                                  ? 'Log in as Driver'
                                  : 'Log in as Student',
                              style: TextStyle(fontSize: 20),
                              selectionColor: Colors.blueAccent,
                            ),
                          ),
                        ]))),
              ),
            )
          ]),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('password', password));
  }

  login() async {
    await _auth
        .loginWithUserEmailandPassword(email, password)
        .then((value) async {
      //auth services instance
      if (value == true) {
        QuerySnapshot snapshot =
            await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                .getUserData(email);
        //sharedrefences
        await HelperFunctions.savedUserLoggedInStatus(true);
        await HelperFunctions.savedUserEmailSF(email);
      }
    });
  }
}
