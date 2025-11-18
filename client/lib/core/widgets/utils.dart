import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';


String rgbToHex(Color color) {
  final red = (color.r * 255).toInt().toRadixString(16).padLeft(2, '0');
  final green = (color.g * 255).toInt().toRadixString(16).padLeft(2, '0');
  final blue = (color.b * 255).toInt().toRadixString(16).padLeft(2, '0');
  final alpha = (color.a * 255).toInt().toRadixString(16).padLeft(2, '0');

  return '$alpha$red$green$blue';
}



Color hexToColor (String hex) {
  return Color(int.parse(hex,radix: 16) + 0xFF000000);
}


void showSnackBar(BuildContext context,String content) {
  ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(content),behavior:SnackBarBehavior.floating));
}



Future<File?> pickAudio() async {
  try{
    final filePickerRes = await FilePicker.platform.pickFiles(
      type: FileType.audio
    );

    if(filePickerRes != null)
    {
      return File(filePickerRes.files.first.xFile.path);
    }

    return null;


  } catch (e) {
    return null;
  }
}



Future<File?> pickImage() async {
  try{
    final filePickerRes = await FilePicker.platform.pickFiles(
      type: FileType.image
    );

    if(filePickerRes != null)
    {
      return File(filePickerRes.files.first.xFile.path);
    }

    return null;


  } catch (e) {
    return null;
  }
}