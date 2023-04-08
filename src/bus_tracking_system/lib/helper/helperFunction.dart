import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  //class used in ui.dart

  static String userLoggedInKey = "LOGGEDINKEY";
  static String usernameKey = "USERNAMEKEY";

  ///to save name
  static String userEmailKey = "USEREMAILKEY";
  // saving the data in shared preferences
  static Future<bool> savedUserLoggedInStatus(bool isUserloggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey,
        isUserloggedIn); //setBool= sets the new value true/false
  }

  static Future<bool> savedUserNameSF(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(usernameKey, userName);
  }

  static Future<bool> savedUserEmailSF(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }
  // getting the data from shared preferences

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey); //tells if the user is logged in
  }

  static Future<String?> getUserEmailFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey); //gives emailid
  }

  static Future<String?> getUserNamefromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(usernameKey); //
  }
}
