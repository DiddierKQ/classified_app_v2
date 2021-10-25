import 'package:classified_app_v2/screens/ads/photoviewer_screen.dart';
import 'package:classified_app_v2/utils/colors_utils.dart';
import 'package:classified_app_v2/utils/size_utils.dart';
import 'package:classified_app_v2/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class AdDetailsScreen extends StatelessWidget {
  //const AdDetailsScreen({Key? key}) : super(key: key);

  var adData = {};

  AdDetailsScreen({
    Key? key,
    required this.adData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialice the Sizeconfig with the context
    SizeConfig(context);

    _launchURL(_url) async => await canLaunch(_url)
        ? await launch(_url)
        : throw 'Could not launch $_url';

    return Scaffold(
      appBar: AppBarWidget(
        title: '',
        enableReturnButton: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                adData['title'],
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(24),
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: getProportionateScreenHeight(2),
              ),
              Text(
                "\$ ${adData['price']}",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(14),
                    fontWeight: FontWeight.normal,
                    color: CustomColors.priceColor),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => PhotoViewerScreen(adData: adData));
                },
                child: Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.36,
                  margin: EdgeInsets.only(
                    top: SizeConfig.screenHeight * 0.01,
                    bottom: SizeConfig.screenHeight * 0.01,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        adData['images'][0],
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.person_outline_outlined,
                    size: SizeConfig.screenHeight * 0.02,
                  ),
                  Text(
                    'All',
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.02,
                  ),
                  Icon(
                    Icons.timer_sharp,
                    size: SizeConfig.screenHeight * 0.02,
                  ),
                  Text(
                    '14 days ago',
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              Text(
                adData['description'],
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(14),
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: CustomColors.buttonColor,
                  minimumSize: Size(
                    SizeConfig.screenWidth,
                    SizeConfig.screenHeight * 0.08,
                  ),
                ),
                onPressed: () {
                  _launchURL('tel:' + adData['contactNumber']);
                },
                child: Text(
                  'Contact seller',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: getProportionateScreenWidth(14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
