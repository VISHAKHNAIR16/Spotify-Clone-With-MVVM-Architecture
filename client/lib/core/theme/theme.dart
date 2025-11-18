import 'package:flutter/material.dart';
import 'package:spotify_clone/core/theme/app_pallete.dart';
import 'package:spotify_clone/core/theme/size_config.dart';

class AppTheme {
  static final width = SizeConfig.screenWidth;
  static final height = SizeConfig.screenHeight;

  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderSide: BorderSide(color: color, width: 3),
    borderRadius: BorderRadius.circular(width * 0.02),
  );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(width * 0.06),
      enabledBorder: _border(Pallete.borderColor),
      focusedBorder: _border(Pallete.gradient1),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Pallete.backgroundColor),
  );


  
}
