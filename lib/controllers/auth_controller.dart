import 'package:classified_app_v2/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class AuthController {
  static Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    return await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => 'success')
        .catchError((error) => error.toString());
  }

  static Future<String> signUp(Users user) async {
    return await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    )
        .then((res) {
      var uid = res.user?.uid;
      return firebaseFirestore
          .collection("users")
          .doc(uid)
          .set({
            "name": user.name,
            "email": user.email,
            "mobile": user.mobile,
            "uid": uid,
          })
          .then((value) => 'success')
          .catchError((error) => error.toString());
    }).catchError((error) => error.toString());
  }

  static Future<String> signOut() async {
    return await FirebaseAuth.instance
        .signOut()
        .then((value) => 'success')
        .catchError((error) => error.toString());
  }
}
