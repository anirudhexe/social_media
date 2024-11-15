import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final String hinttext;
  final bool password;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  const TextFieldInput(
      {super.key,
      required this.hinttext,
      required this.password,
      required this.textEditingController,
      required this.textInputType});

  @override
  Widget build(BuildContext context) {
    final inputborder = OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.white), //<-- SEE HERE
        borderRadius: BorderRadius.circular(10.0));
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        enabledBorder: inputborder,
        focusedBorder: inputborder,
        border: inputborder,
        hintText: hinttext,
      ),
      keyboardType: textInputType,
      obscureText: password,
    );
  }
}
