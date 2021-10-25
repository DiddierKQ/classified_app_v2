import 'package:classified_app_v2/screens/ads/edit_ad_screen.dart';
import 'package:classified_app_v2/utils/colors_utils.dart';
import 'package:classified_app_v2/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AdHorizontalCardWidget extends StatelessWidget {
  //const AdHorizontalCardWidget({Key? key}) : super(key: key);

  var adData = {};

  AdHorizontalCardWidget({
    Key? key,
    required this.adData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig(context);

    return GestureDetector(
      onTap: () {
        Get.to(() => AdEditScreen(adData: adData));
      },
      child: Container(
        margin: EdgeInsets.only(
            left: SizeConfig.screenWidth * 0.02,
            right: SizeConfig.screenWidth * 0.02,
            top: SizeConfig.screenHeight * 0.02),
        decoration: BoxDecoration(
          border: Border.all(
            color: CustomColors.greyColor.withOpacity(0.5),
          ),
          shape: BoxShape.rectangle,
        ),
        child: Row(
          children: [
            Container(
              // margin: const EdgeInsets.only(
              //     right: 8, left: 8, top: 8, bottom: 8),
              width: SizeConfig.screenHeight * 0.14,
              height: SizeConfig.screenHeight * 0.14,
              decoration: BoxDecoration(
                // borderRadius:
                //     const BorderRadius.all(Radius.circular(14)),
                //color: Colors.blue.withOpacity(0.2),
                image: DecorationImage(
                  //fit: BoxFit.cover,
                  image: NetworkImage(
                    adData['images'][0],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      adData['title'],
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(14),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
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
                    Text(
                      "\$ ${adData['price']}",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(14),
                        color: CustomColors.priceColor,
                      ),
                    ),
                  ],
                ),
              ),
              flex: 100,
            )
          ],
        ),
      ),
    );
  }
}
