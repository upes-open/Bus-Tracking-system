import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  static saveUser(String name, email, String uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .get({'email': email} as GetOptions?);
  }
}
