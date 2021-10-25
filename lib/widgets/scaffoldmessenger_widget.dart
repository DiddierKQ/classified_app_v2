// Create a dynamic notification
import 'package:classified_app_v2/utils/size_utils.dart';
import 'package:flutter/material.dart';

class CustomWidgets {
  CustomWidgets._();
  static buildErrorSnackbar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("$message"),
      ),
    );
  }
}

class ScaffoldMessengerWidget extends StatelessWidget {
  //const ScaffoldMessengerWidget({Key? key}) : super(key: key);

  String message;
  String type;

  ScaffoldMessengerWidget({
    Key? key,
    required this.message,
    this.type = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: SnackBar(
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
