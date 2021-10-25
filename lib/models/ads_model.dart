import 'package:cloud_firestore/cloud_firestore.dart';

class Ads {

  String? id;
  late String title;
  late String description;
  late String price;
  late List<dynamic> images;
  late String uid;
  late String contactNumber;

  Ads({
    required this.title,
    required this.description,
    required this.price,
    required this.images,
    required this.uid,
    required this.contactNumber,
  });

  Ads.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    title = documentSnapshot['title'];
    description = documentSnapshot['description'];
    price = documentSnapshot['price'];
    images = documentSnapshot['images'];
    uid = documentSnapshot['uid'];
    contactNumber = documentSnapshot['contactNumber'];
  }
}
