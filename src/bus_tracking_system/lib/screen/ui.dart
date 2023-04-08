import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class UI extends StatefulWidget {
  @override
  _UIState createState() => _UIState();
}

class _UIState extends State<UI> {
  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
    print('Firebase initialized');
  }

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  bool isStudent = true;
  late String email;
  late String password;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _register() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('User registered successfully: ${userCredential.user!.uid}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

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
                  setState(() {
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
                _register();
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
}
