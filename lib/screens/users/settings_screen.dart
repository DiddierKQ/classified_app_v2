import 'package:classified_app_v2/screens/ads/my_ads_screen.dart';
import 'package:classified_app_v2/screens/users/edit_profile_screen.dart';
import 'package:classified_app_v2/utils/colors_utils.dart';
import 'package:classified_app_v2/utils/size_utils.dart';
import 'package:classified_app_v2/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  //const SettingsScreen({Key? key}) : super(key: key);

  var userData = {};

  SettingsScreen({
    Key? key,
    required this.userData,
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
        title: 'Settings',
        enableReturnButton: true,
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: SizeConfig.screenWidth * 0.02,
          right: SizeConfig.screenWidth * 0.02,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    onTap: () {
                      Get.to(() => EditProfileScreen(
                            userData: userData,
                          ));
                    },
                    leading: CircleAvatar(
                      backgroundColor: CustomColors.greyColor,
                      backgroundImage: userData['imgURL'] != ''
                          ? NetworkImage(userData['imgURL'])
                          : null,
                    ),
                    title: Text(
                      userData['name'],
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(14),
                      ),
                    ),
                    subtitle: Text(
                      userData['mobile'],
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(12),
                      ),
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        Get.to(() => EditProfileScreen(
                              userData: userData,
                            ));
                      },
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          color: CustomColors.buttonColor,
                          fontSize: getProportionateScreenWidth(14),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(() => const MyAdsScreen());
                    },
                    leading: Icon(
                      Icons.post_add_outlined,
                      size: SizeConfig.screenHeight * 0.04,
                    ),
                    title: Text(
                      "My ads",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(14),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      _launchURL('https://itk.mx/');
                    },
                    leading: Icon(
                      Icons.person_outline_outlined,
                      size: SizeConfig.screenHeight * 0.04,
                    ),
                    title: Text(
                      "About us",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(14),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      _launchURL(
                          'https://www.linkedin.com/in/diddierkantunquintal/');
                    },
                    leading: Icon(
                      Icons.contacts_outlined,
                      size: SizeConfig.screenHeight * 0.04,
                    ),
                    title: Text(
                      "Contact us",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
