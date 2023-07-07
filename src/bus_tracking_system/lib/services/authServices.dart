//import 'package:chat_app/helper/helper_function.dart';
import 'package:bus_tracking_system/services/databaseServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //login
  Future loginWithUserEmailandPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              //firebase class=User
              //signinwithemailandpass
              email: email,
              password: password))
          .user!;

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //register
  Future registerUserWithEmailandPassword(
      String fullName, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        await DatabaseService(uid: user.uid).savingUserData(fullName, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}

  //sign out
  /*Future signOut() async {
    try {
      await HelperFunctions.savedUserLoggedInStatus(false);//helperfunction is a file with shared preference
      await HelperFunctions.savedUserEmailSF("");
      await HelperFunctions.savedUserNameSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }*/

