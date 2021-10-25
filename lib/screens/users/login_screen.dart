import 'package:classified_app_v2/screens/ads/list_ads_screen.dart';
import 'package:classified_app_v2/screens/users/signup_screen.dart';
import 'package:classified_app_v2/utils/colors_utils.dart';
import 'package:classified_app_v2/utils/size_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Create the key to the form
  final _formkey = GlobalKey<FormState>();
  // Textfield values
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  login() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: _emailCtrl.text,
      password: _passwordCtrl.text,
    )
        .then((value) {
      Get.to(()=> const ListAdsScreen());
    }).catchError((e) {
      showScaffoldMessenger(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    // Initialice the Sizeconfig with the context
    SizeConfig(context);

    return Scaffold(
      backgroundColor: CustomColors.scaffoldBackgroundColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(
              FocusNode(),
            ); // Function to hide the keyboard once you clic outside the textfield
          },
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildLogo(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.04,
                  ),
                  buildEmail(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  buildPassword(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  buildLoginButton(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.03,
                  ),
                  buildSignUpText(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.04,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Create the logo
  Stack buildLogo() {
    return Stack(
      children: [
        Image.asset(
          "assets/background.png",
          width: SizeConfig.screenWidth,
          fit: BoxFit.cover,
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            top: SizeConfig.screenHeight * 0.12,
            bottom: SizeConfig.screenHeight * 0.12,
          ),
          child: Image.asset(
            "assets/logo.png",
            width: SizeConfig.screenWidth * 0.50,
          ),
        ),
      ],
    );
  }

  // Create the email TextField
  Container buildEmail() {
    return Container(
      padding: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.04,
        right: SizeConfig.screenWidth * 0.04,
      ),
      child: TextFormField(
        controller: _emailCtrl,
        keyboardType: TextInputType.emailAddress,
        cursorColor: CustomColors.greyColor,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.greyColor),
          ),
          labelText: 'Email address',
          labelStyle: TextStyle(
            //fontSize: 20,
            color: CustomColors.greyColor,
          ),
        ),
        //onChanged: (value) => setState(() => _emailCtrl.text = value),
        onSaved: (value) => setState(() => _emailCtrl.text = value!),
        validator: (value) {
          const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
          final regExp = RegExp(pattern);

          if (value!.isEmpty) {
            return 'Enter an email';
          } else if (!regExp.hasMatch(value)) {
            return 'Enter a valid email';
          } else {
            return null;
          }
        },
      ),
    );
  }

  // Create the password TextField
  Container buildPassword() {
    return Container(
      padding: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.04,
        right: SizeConfig.screenWidth * 0.04,
      ),
      child: TextFormField(
        controller: _passwordCtrl,
        keyboardType: TextInputType.text,
        cursorColor: CustomColors.greyColor,
        obscureText: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.greyColor),
          ),
          labelText: 'Password',
          labelStyle: TextStyle(
            //fontSize: 20,
            color: CustomColors.greyColor,
          ),
        ),
        //onChanged: (value) => setState(() => _passwordCtrl.text = value),
        onSaved: (value) => setState(() => _passwordCtrl.text = value!),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter a password';
          } else {
            return null;
          }
        },
      ),
    );
  }

  // Create the login button
  Container buildLoginButton() {
    return Container(
      padding: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.04,
        right: SizeConfig.screenWidth * 0.04,
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: CustomColors.buttonColor,
          minimumSize: Size(
            SizeConfig.screenWidth,
            SizeConfig.screenHeight * 0.08,
          ),
        ),
        onPressed: () {
          final isValid = _formkey.currentState!.validate();

          if (isValid) {
            _formkey.currentState!.save();
            login();
          }
        },
        child: Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenWidth(14),
          ),
        ),
      ),
    );
  }

  // Create the sign up text
  Container buildSignUpText() {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        child: Text(
          "Don't have any account?",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(14),
            color: CustomColors.buttonColor,
          ),
        ),
        onPressed: () {
          Get.to(() => const SignUpScreen());
        },
      ),
    );
  }

  // Create a dynamic notification
  showScaffoldMessenger(message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(12),
          ),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
