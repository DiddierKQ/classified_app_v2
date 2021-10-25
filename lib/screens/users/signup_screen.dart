import 'package:classified_app_v2/controllers/auth_controller.dart';
import 'package:classified_app_v2/models/users_model.dart';
import 'package:classified_app_v2/screens/users/login_screen.dart';
import 'package:classified_app_v2/utils/colors_utils.dart';
import 'package:classified_app_v2/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Create the key to the form
  final _formkey = GlobalKey<FormState>();
  // Textfield values
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _mobileNumberCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  // register() {
  //   FirebaseAuth.instance
  //       .createUserWithEmailAndPassword(
  //     email: _emailCtrl.text,
  //     password: _passwordCtrl.text,
  //   )
  //       .then((res) {
  //     showScaffoldMessenger('User created successfully', 'success');
      
  //     var uid = res.user?.uid;
  //     FirebaseFirestore.instance.collection("users").doc(uid).set({
  //       "name": _nameCtrl.text,
  //       "email": _emailCtrl.text,
  //       "mobile": _mobileNumberCtrl.text,
  //       "uid": uid,
  //     });
  //     // Get.to(HomeScreen());
  //   }).catchError((e) {
  //     showScaffoldMessenger(e.toString());
  //   });
  // }

  signupUsingController() async {
    final user = Users(
      name: _nameCtrl.text,
      email: _emailCtrl.text,
      password: _passwordCtrl.text,
      mobile: _mobileNumberCtrl.text,
    );
    var res = await AuthController.signUp(user);
    if (res == 'success') {
      showScaffoldMessenger('User created successfully', 'success');
    } else {
      showScaffoldMessenger(res);
    }
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
                  buildName(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  buildEmail(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  buildMobileNumber(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  buildPassword(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  buildSignUpButton(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.03,
                  ),
                  buildLoginText(),
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

  // Create the name TextField
  Container buildName() {
    return Container(
      padding: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.04,
        right: SizeConfig.screenWidth * 0.04,
      ),
      child: TextFormField(
        controller: _nameCtrl,
        keyboardType: TextInputType.text,
        cursorColor: CustomColors.greyColor,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.greyColor),
          ),
          labelText: 'Name',
          labelStyle: TextStyle(
            //fontSize: 20,
            color: CustomColors.greyColor,
          ),
        ),
        onSaved: (value) => setState(() => _nameCtrl.text = value!),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter a name';
          } else {
            return null;
          }
        },
      ),
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

  // Create the mobile number TextField
  Container buildMobileNumber() {
    return Container(
      padding: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.04,
        right: SizeConfig.screenWidth * 0.04,
      ),
      child: TextFormField(
        controller: _mobileNumberCtrl,
        keyboardType: TextInputType.text,
        cursorColor: CustomColors.greyColor,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.greyColor),
          ),
          labelText: 'Mobile number',
          labelStyle: TextStyle(
            //fontSize: 20,
            color: CustomColors.greyColor,
          ),
        ),
        onSaved: (value) => setState(() => _mobileNumberCtrl.text = value!),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter a mobile number';
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

  // Create the sign up button
  Container buildSignUpButton() {
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
            //register();
            signupUsingController();
          }
        },
        child: Text(
          'Register Now',
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenWidth(14),
          ),
        ),
      ),
    );
  }

  // Create the login text
  Container buildLoginText() {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        child: Text(
          'Already have an account?',
          style: TextStyle(
            fontSize: getProportionateScreenWidth(14),
            color: CustomColors.buttonColor,
          ),
        ),
        onPressed: () {
          Get.to(() => const LoginScreen());
        },
      ),
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
