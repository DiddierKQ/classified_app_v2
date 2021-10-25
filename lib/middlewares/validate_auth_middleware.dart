import 'package:classified_app_v2/screens/ads/list_ads_screen.dart';
import 'package:classified_app_v2/screens/users/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ValidateAuthScreen extends StatefulWidget {
  const ValidateAuthScreen({Key? key}) : super(key: key);

  @override
  _ValidateAuthScreenState createState() => _ValidateAuthScreenState();
}

class _ValidateAuthScreenState extends State<ValidateAuthScreen> {
  
  var _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    validateAuth();
  }

  validateAuth() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        _isLoggedIn = (user == null) ? false : true;
      });
      // if (user == null) {
      //   setState(() {
      //     _isLoggedIn = false;
      //   });
      // } else {
      //   setState(() {
      //     _isLoggedIn = true;
      //   });
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoggedIn ? const ListAdsScreen() : const LoginScreen();
  }
}
