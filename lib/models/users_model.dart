import 'package:cloud_firestore/cloud_firestore.dart';

class Users {

  String? id;
  late String name;
  late String email;
  late String password;
  late String mobile;
  late String imgURL;
  late String uid;

  Users({
    required this.name,
    required this.email,
    required this.mobile,
    this.password = '',
    this.imgURL = '',
    this.uid = '',
  });

  Users.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    name = documentSnapshot['name'];
    email = documentSnapshot['email'];
    mobile = documentSnapshot['mobile'];
    imgURL = documentSnapshot['imgURL'];
    uid = documentSnapshot['uid'];
  }
}