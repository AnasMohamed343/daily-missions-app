import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String buttonText;
  Function onButtonClickedCallBack;
  CustomButton(
      {required this.buttonText, required this.onButtonClickedCallBack});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xff5D9CEC)),
          // Other styling properties can be adjusted here
        ),
        onPressed: () {
          onButtonClickedCallBack();
        },
        child: Text(buttonText));
  }
}
