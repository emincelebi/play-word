import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:play_word/constants/constants.dart';

class DarkTheme {
  var theme = ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: TextStyle(fontSize: Constants.appBarSize),
      centerTitle: true,
      backgroundColor: Constants.appBarColorDark,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(Constants.appBarCircular))),
    ),
    scaffoldBackgroundColor: Constants.scaffoldColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(
          Size(Constants.eleButtonwidth, Constants.eleButtonheigth),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.buttonCircular),
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateColor.resolveWith((states) => Constants.appBarColorDark),
      ),
    ),
  );
}
