
import 'package:classified_app_v2/models/ads_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

class AdsController extends GetxController {

  Rx<List<Ads>> adsList = Rx<List<Ads>>([]);
  List<Ads> get ads => adsList.value;

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
}
