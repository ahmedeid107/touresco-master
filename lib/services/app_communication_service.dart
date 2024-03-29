import 'package:flutter/material.dart';

class AppCommunicationService {
  static GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  AppCommunicationService() {
    //
  }

  static void showGlobalSnackBar(String text) {
    rootScaffoldMessengerKey.currentState!
        .showSnackBar(SnackBar(content: Text(text)));
  }

  static String replaceArabicNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }
    return input;
  }
}
