import 'package:flutter/material.dart';

typedef Validator = String? Function(String?);

class CustomTextFormField extends StatelessWidget {
  String labelText;
  TextInputType keyboardType;
  bool isObscureText;
  Validator? validator;
  TextEditingController? controller;
  int maxLines;
  CustomTextFormField({
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.isObscureText = false, //text will be visible
    this.validator,
    this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        //can make validation for inputs in (TextFormField) , but in (TextField) can't.
        keyboardType: keyboardType,
        obscureText: isObscureText,
        validator: validator,
        controller: controller,
        maxLines: maxLines,
        minLines: maxLines,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: labelText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(color: Colors.blue, width: 2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(color: Colors.blue, width: 2)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(color: Colors.red, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(color: Colors.blue, width: 2)),
        ),
      ),
    );
  }
}
