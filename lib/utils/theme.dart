import 'package:flutter/material.dart';
import 'package:touresco/utils/constants.dart';

ThemeData theme() {
  return ThemeData(
    primarySwatch: primaryAppSwatch,
    canvasColor: kCanvasColor,
    appBarTheme: myAppBarTheme(),
//    textTheme: myTextTheme(),
    inputDecorationTheme: myInputFieldTheme(),
  );
}

AppBarTheme myAppBarTheme() => const AppBarTheme(
      color: kCanvasColor,
      elevation: 0,
      foregroundColor: kTitleBlackTextColor,
    );

InputDecorationTheme myInputFieldTheme() => const InputDecorationTheme(
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
    );

TextTheme myTextTheme() => const TextTheme(
      bodyMedium: TextStyle(
        // Any Text
        color: kNormalTextColor,
      ),
      bodyLarge: TextStyle(
        //Title
        color: kTitleBlackTextColor,
        fontSize: 19,
        fontWeight: FontWeight.bold,
      ),
    );

TextStyle textTitle(Color color) => TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 15,
      color: color,
    );
TextStyle textTitle1(Color color) => TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 15,
      color: color,
    );

TextStyle textSubtitle(Color color) => TextStyle(
      fontSize: 12,
      color: color,
    );
