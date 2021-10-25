import 'package:classified_app_v2/models/ads_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

class AdsController extends GetxController {

  Rx<List<Ads>> adsList = Rx<List<Ads>>([]);
  List<Ads> get ads => adsList.value;

  @override
  void onReady() {
    adsList.bindStream(getAds());
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
