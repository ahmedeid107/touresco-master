// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

const String appTitle = 'FlowerApp';

//App Primary Swatch
const primaryAppSwatch = const MaterialColor(0xFF27b0ec, const <int, Color>{
  50: Color(0xFFe9f7fd),
  100: Color(0xFFd4effb),
  200: Color(0xFFbee7f9),
  300: Color(0xFFa9dff7),
  400: Color(0xFF93d8f6),
  500: Color(0XFF7dd0f4),
  600: Color(0xFF68c8f2),
  700: Color(0xFF52c0f0),
  800: Color(0xFF3db8ee),
  900: Color(0xFF27b0ec)
});

const String mainUrl = 'https://touresco.net/mobile/mobile_api_new.php';
// Colors
const Color kPrimaryColor = Color(0xFF27b0ec);
const Color kSecondPrimaryColor = Color(0xFF436BA7);
//const Color kPrimaryColorLight = Color(0xFFD5EFC4);
const Color kCanvasColor = Color(0xfffafafa);

const Color kTitleBlackTextColor = Color(0xFF4D4D4D);
const Color kNormalTextColor = Color(0xFF636363);
const Color kLightGreyColor = Color(0xFF969892);

//Regex

const String emailRegex =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

const String phoneRegex = r"^(?:[+0]9)?[0-9]{10}$";

// App UTILS FUNCTIONS (FLOWERUP)
double calculatePriceAfterDiscount(double price, int discount) =>
    discount == 0 ? price : (price * (1 - discount / 100));
