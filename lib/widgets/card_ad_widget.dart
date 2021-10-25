import 'package:classified_app_v2/screens/ads/details_ad_screen.dart';
import 'package:classified_app_v2/utils/colors_utils.dart';
import 'package:classified_app_v2/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AdCardWidget extends StatefulWidget {
  //const AdCardWidget({ Key? key }) : super(key: key);
  var adData = {};

  AdCardWidget({
    Key? key,
    required this.adData,
  }) : super(key: key);

  @override
  _AdCardWidgetWidgetState createState() => _AdCardWidgetWidgetState();
}

class _AdCardWidgetWidgetState extends State<AdCardWidget> {
  @override
  Widget build(BuildContext context) {
    // Initialice the Sizeconfig with the context
    SizeConfig(context);

    return Container(
      height: SizeConfig.screenHeight * 0.60,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Stack(
        children: [
          Align(
            child: GestureDetector(
              onTap: () {
                Get.to(() => AdDetailsScreen(adData: widget.adData));
              },
              child: Container(
                //width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      widget.adData['images'][0],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: SizeConfig.screenHeight * 0.10,
              width: double.infinity,
              color: CustomColors.mainColor.withOpacity(0.5),
              child: Container(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 4.0, left: 16.0, right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        widget.adData['title'],
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "\$ ${widget.adData['price']}",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            fontWeight: FontWeight.normal,
                            color: CustomColors.priceColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
