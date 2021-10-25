import 'dart:io';
import 'dart:math';

import 'package:classified_app_v2/models/ads_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseStorage firebaseStorage = FirebaseStorage.instance;
FirebaseAuth auth = FirebaseAuth.instance;

class AdsController extends GetxController {

  Rx<List<Ads>> adsList = Rx<List<Ads>>([]);
  List<Ads> get ads => adsList.value;

  @override
  void onReady() {
    adsList.bindStream(getAds());
  }

  static Future<dynamic> uploadMultiImages() async {
    var picker = ImagePicker();
    var pickedFiles = await picker.pickMultiImage();

    if (pickedFiles!.isNotEmpty) {
      final List imagesUploaded = [];
      for (var image in pickedFiles) {
        File img = File(image.path);
        var rng = Random();
        firebaseStorage
            .ref()
            .child("images")
            .child(rng.nextInt(10000).toString())
            .putFile(img)
            .then((res) {
          res.ref.getDownloadURL().then((url){
            imagesUploaded.add(url);
          });
        }).catchError((error) => error);
      }
      return imagesUploaded;
    } else {
      return 'Select photos';
    }
  }

  // Method to create a new ad
  static Future<String> createAd(Ads ads) async {
    return await firebaseFirestore
        .collection("ads")
        .add({
          "title": ads.title,
          "description": ads.description,
          "price": ads.price,
          "contactNumber": ads.contactNumber,
          "uid": auth.currentUser!.uid,
          "images": ads.images,
        })
        .then((value) => 'success')
        .catchError((error) => error.toString());
  }

  // Method to update an ad
  static Future<String> updateAd(Ads ads, adId) async {
    return await FirebaseFirestore.instance
        .collection("ads")
        .doc(adId)
        .update({
          "title": ads.title,
          "description": ads.description,
          "price": ads.price,
          "contactNumber": ads.contactNumber,
          "uid": auth.currentUser!.uid,
          "images": ads.images,
        })
        .then((value) => 'success')
        .catchError((error) => error.toString());
  }

  static getAds(){
    return firebaseFirestore
        .collection('ads')
        .doc(auth.currentUser!.uid)
        .collection('todos')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Ads> ads = [];
      for (var ad in query.docs) {
        final todoModel =
            Ads.fromDocumentSnapshot(documentSnapshot: ad);
        ads.add(todoModel);
      }
      return ads;
    });
  }
}
