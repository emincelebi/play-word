import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:play_word/constants/constants.dart';

class LightTheme {
  late ThemeData theme;

  LightTheme() {
    theme = ThemeData.light().copyWith(
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: TextStyle(fontSize: Constants.appBarSize),
        centerTitle: true,
        backgroundColor: Constants.scaffoldColorLigth,
        elevation: 0,
      ),
      scaffoldBackgroundColor: Constants.scaffoldColorLigth,
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
          foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
        ),
      ),
    );
  }
}
