import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  final String defaultLanguage;

  LanguageProvider({required this.defaultLanguage}) {
    _currentLanguage = defaultLanguage;
  }

  String _currentLanguage = '';
  String get currentLanguage => _currentLanguage;
  set currentLanguage(value) {
    _currentLanguage = value;
    notifyListeners();
  }
}
