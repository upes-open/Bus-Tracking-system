import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bus_tracking_system/Constants/constants.dart';
import 'package:bus_tracking_system/helper/helperFunction.dart';
import 'package:bus_tracking_system/screen/maps.dart';
import 'package:bus_tracking_system/screen/splash.dart';
import 'package:bus_tracking_system/services/authServices.dart';
import 'package:bus_tracking_system/services/databaseServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bus_tracking_system/componentes/MyButton.dart';
import 'package:bus_tracking_system/componentes/My_TextField.dart';

import 'locations_page.dart';

class UI extends StatefulWidget {
  const UI({Key? key}) : super(key: key);

  @override
  State<UI> createState() => _UIState();
}

class _UIState extends State<UI> {
  final AuthService _auth = AuthService();
  bool isStudent = true;
  late final String email;
  late final String password;
  final _formKey = GlobalKey<FormState>(); // Updated key name
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool passToggle = false;

  get validator => null;

  void toggleLoginOption() {
    setState(() {
      isStudent = !isStudent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFF8F8F8),
      backgroundColor: Color(0xFFF8F9FD),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //backgroundColor: Color.fromARGB(255, 224, 224, 244),

              // backgroundColor: Color(0xFFE8F5E9),

              SizedBox(height: 100),
              Text(
                'Sign up',
                style: TextStyle(
                  //color: Color(0xFF34BAC3),
                  color: Color(0xFF1CBBBE),
                  fontFamily: 'Avenir',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
              SizedBox(height: 80),
              MyTextField(
                controller: emailController,
                obscureText: false,
                hintText: isStudent
                    ? 'Enter student email'
                    : 'Enter bus-driver email',
                validator: (value) {
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value!);

                  if (value.isEmpty) {
                    return "Enter Email";
                  } else if (!emailValid) {
                    return "Enter valid Email";
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: isStudent
                      ? 'Enter student email'
                      : 'Enter bus-driver email',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(169, 106, 196, 207),
                    fontSize: 18.0,
                  ),
                  border: InputBorder.none,
                ),
              ),
              SizedBox(height: 20),

              MyTextField(
                keyboardType: TextInputType.emailAddress,
                controller: passController,
                obscureText: passToggle,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        passToggle = !passToggle;
                      });
                    },
                    child: Icon(
                      passToggle ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Password';
                  } else if (passController.text.length < 9) {
                    return "Password length should be more than 9 characters";
                  }
                  return null;
                },
                hintText: 'Password',
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: toggleLoginOption,
                child: Text(
                  isStudent ? 'Log in as Driver' : 'Log in as Student',
                  style: TextStyle(fontSize: 20),
                  selectionColor: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 150),
              MyButton(
                label: 'Sign up',
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    String password = passController.text;
                    dynamic result = await _auth.loginWithUserEmailandPassword(
                      emailController.text,
                      password,
                    );
                    if (result == null) {
                      // Handle login failure
                    } else {
                      print("Login Successful");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return LocationsPage();
                          },
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
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
                .getUserData(email);MyButton(
  label: 'Sign up',
  onTab: () async {
    if (_formfield.currentState!.validate()) {
      String password = passController.text; // Assign password from passController
      dynamic result = await _auth.loginWithUserEmailandPassword(
        emailController.text,
        password,
      );
      if (result == null) {
        // Handle login failure
      } else {
        print("Login Successful");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return LocationsPage();
            },
          ),
        );
      }
    }
  },
),

        //sharedrefences
        await HelperFunctions.savedUserLoggedInStatus(true);
        await HelperFunctions.savedUserEmailSF(email);
      }
    });
  }
}


/*

if (_formfield.currentState!.validate()) {
                      print("Login Successful");
                      emailController.clear();
                      passController.clear();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return LocationsPage();
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
                              prefixIcon: Icon(Icons.email),
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
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: passController,
                            obscureText: passToggle,
                            decoration: InputDecoration(
                              labelText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.white),
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
                              return null;
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
                              child: Center(
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
        )
    ),
    );
      }
    });
  }
}
*/
*/
