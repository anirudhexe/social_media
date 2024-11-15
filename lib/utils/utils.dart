import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//this function picks an image from source and returns it's bytes
pickImage(ImageSource source) async {
  //source is wherever we're taking the image from like cam or gallery{
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) return await _file.readAsBytes();
  print('no image selected');
}

showSnackbar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}
