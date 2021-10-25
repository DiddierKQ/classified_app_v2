import 'package:classified_app_v2/utils/colors_utils.dart';
import 'package:classified_app_v2/utils/size_utils.dart';
import 'package:classified_app_v2/widgets/appbar_widget.dart';
import 'package:classified_app_v2/widgets/horizontal_card_ad_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({Key? key}) : super(key: key);

  @override
  _MyAdsScreenState createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  
  List _ads = [];

  getMyAds() async {
    try {
     var uid = FirebaseAuth.instance.currentUser!.uid;
      FirebaseFirestore.instance
          .collection("ads")
          .where("uid", isEqualTo: uid)
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
            "ad_id": ad.id,
          });
        }
        setState(() {
          _ads = tmpAds;
        });
      }).catchError((e) {
        showScaffoldMessenger(e.toString());
      });
    } catch (e) {
      showScaffoldMessenger(e.toString());
    }
  }

  @override
  void initState() {
    getMyAds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.scaffoldBackgroundColor,
      appBar: AppBarWidget(
        title: 'My ads',
        enableReturnButton: true,
      ),
      body: RefreshIndicator(
        backgroundColor: CustomColors.buttonColor,
        color: CustomColors.whiteColor,
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              getMyAds();
            });
            showScaffoldMessenger('Page Refreshed', 'success');
          });
        },
        child: Center(
          child: Container(
            //padding: const EdgeInsets.all(4.0),
            child: _ads.isEmpty ? const Text('') : buildLisView(),
          ),
        ),
      ),
    );
  }

  ListView buildLisView() {
    return ListView.builder(
      itemCount: _ads.length,
      itemBuilder: (bc, index) {
        return AdHorizontalCardWidget(
          adData: _ads[index],
        );
      },
    );
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
