import 'package:classified_app_v2/screens/ads/create_ad_screen.dart';
import 'package:classified_app_v2/screens/users/settings_screen.dart';
import 'package:classified_app_v2/utils/colors_utils.dart';
import 'package:classified_app_v2/utils/size_utils.dart';
import 'package:classified_app_v2/widgets/card_ad_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListAdsScreen extends StatefulWidget {
  const ListAdsScreen({Key? key}) : super(key: key);

  @override
  _ListAdsScreenState createState() => _ListAdsScreenState();
}

class _ListAdsScreenState extends State<ListAdsScreen> {

  List _ads = [];
  var _user = {};

  getAds() async {
    await FirebaseFirestore.instance
        .collection("ads")
        .get()
        .then((res) {
      var tmpAds = [];
      for (var ad in res.docs) {
        tmpAds.add({
          "title": ad.data()["title"],
          "description": ad.data()["description"],
          "price": ad.data()["price"],
          "contactNumber": ad.data()["contactNumber"],
          "images": ad.data()["images"],
        });
      }
      setState(() {
        _ads = tmpAds;
        getCurrentUser();
      });
    }).catchError((e) {
      showScaffoldMessenger(e.toString());
    });
  }

  getCurrentUser() {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("users").doc(uid).get().then((user) {
      var userData = user.data()!;
      setState(() {
        _user = userData;
      });
    });
  }

  @override
  void initState() {
    getAds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors.mainColor,
        title: const Text(
          'Ads Listing',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => SettingsScreen(
                    userData: _user,
                  ));
            },
            child: Container(
              alignment: Alignment.center,
              child: buildUserImg(),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        backgroundColor: CustomColors.buttonColor,
        color: CustomColors.whiteColor,
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              getAds();
            });
            showScaffoldMessenger('Page Refreshed', 'success');
          });
        },
        child: Container(
          padding: EdgeInsets.all(
            SizeConfig.screenWidth * 0.02,
          ),
          child: _ads.isEmpty ? const Text('') : buildGridView(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: CustomColors.buttonColor,
        foregroundColor: Colors.white,
        onPressed: () {
          Get.to(() => const CreateAdScreen());
        },
        child: const Icon(Icons.add_a_photo_outlined),
      ),
    );
  }

  // Load the img when it's ready
  Widget buildUserImg() {
    return Container(
      padding: EdgeInsets.only(
        right: getProportionateScreenWidth(4),
      ),
      child: CircleAvatar(
        backgroundColor: CustomColors.greyColor,
        backgroundImage:
            _user.isNotEmpty ? NetworkImage(_user["imgURL"]) : null,
      ),
    );
  }

  //Build the GridView with all the content
  GridView buildGridView() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: getProportionateScreenWidth(8),
          mainAxisSpacing: getProportionateScreenWidth(8),
        ),
        itemCount: _ads.length,
        itemBuilder: (BuildContext context, index) {
          return AdCardWidget(adData: _ads[index]);
        });
  }

  // Create a dynamic notification
  showScaffoldMessenger(message, [type = '']) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(12),
          ),
        ),
        backgroundColor: type != '' ? Colors.green : Colors.red,
      ),
    );
  }
}
