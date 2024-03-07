import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:touresco/models/user_model.dart';
import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/services/service_collector.dart';

class ChangePasswordDialogViewModel with ChangeNotifier {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  String oldPassword = '';
  String newPassword = '';

  bool _isPasswordVisible = true;
  bool get isPasswordVisible => _isPasswordVisible;
  set isPasswordVisible(value) {
    _isPasswordVisible = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  void submit(BuildContext context) async {
    if (formState.currentState!.validate()) {
      formState.currentState!.save();

      try {
        isLoading = true;
        await ServiceCollector.getInstance().authService.changePassword(
            Provider.of<AuthProvider>(context, listen: false).user.id,
            oldPassword,
            newPassword);

//update on prefs
        final prefs = await SharedPreferences.getInstance();
        UserModel user = Provider.of<AuthProvider>(context, listen: false).user;
         user.password = newPassword;
        prefs.setString('user', json.encode(user));

        isLoading = false;

        Navigator.of(context).pop(
            ServiceCollector.getInstance().currentLanguage == 'en'
                ? 'You have update your password'
                : 'لقد قمت بتغيير كلمة المرور');
      } catch (error) {
        Navigator.of(context).pop(error);
      }
    }
  }
}
