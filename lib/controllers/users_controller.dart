import 'package:classified_app_v2/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

class UserController extends GetxController {

  // Method to update the user
  static Future<String> updateUserProfile(Users user) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser!.uid)
        .update({
          "name": user.name,
          "email": user.email,
          "mobile": user.mobile,
          "imgURL": user.imgURL,
        })
        .then((value) => 'success')
        .catchError((error) => error.toString());
  }
}
