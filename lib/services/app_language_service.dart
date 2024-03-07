import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguageService {
  Future<String> syncDefaultLanguage() async {
    String systemLanguage = Platform.localeName;

    if (systemLanguage.contains('en_')) {
      systemLanguage = 'en';
    } else if (systemLanguage.contains('ar_')) {
      systemLanguage = 'ar';
    } else {
      systemLanguage = 'en';
    }

    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('language')) {
      // if prefs not set
      prefs.setString('language', systemLanguage);
      return systemLanguage;
    }

    return prefs.getString('language')!;
  }

  Future<void> updateLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('language', language);
  }
}
