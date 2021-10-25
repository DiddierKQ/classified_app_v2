import 'dart:io';
import 'dart:math';

import 'package:classified_app_v2/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseStorage firebaseStorage = FirebaseStorage.instance;
FirebaseAuth auth = FirebaseAuth.instance;

class UserController {

  static Future<dynamic> uploadImg() async {
    var picker = ImagePicker();
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile!.path.isNotEmpty) {      
      File image = File(pickedFile.path);
      var rng = Random();

      return await firebaseStorage
          .ref()
          .child("users")
          .child(rng.nextInt(10000).toString())
          .putFile(image)
          .then((res) => res.ref
              .getDownloadURL()
              .then((url) => url)
              .catchError((error) => error));
    } else {
      return 'Select a photo';
    }
  }

  // Method to update the user profile
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
