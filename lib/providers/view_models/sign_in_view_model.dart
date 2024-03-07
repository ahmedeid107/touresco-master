import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:touresco/Interfaces/i_auth.dart';
import 'package:touresco/models/user_model.dart';

import 'package:touresco/providers/auth_provider.dart';

class SignInViewModel with ChangeNotifier {
  final IAuth authService;
  SignInViewModel({required this.authService});

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  get formState => _formState;

   Map<String, dynamic> fromData = {};

  set email(final String value) => fromData['email'] = value;
  String get email => fromData['email'];

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(final bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isHidingPassword = true;
  bool get isHidingPassword => _isHidingPassword;
  set isHidingPassword(final bool value) {
    _isHidingPassword = value;
    notifyListeners();
  }

  set password(final String value) => fromData['password'] = value;
  String get password => fromData['password'];

  bool _isKeepLogged = false;
  bool get isKeeplogged => _isKeepLogged;
  set isKeeplogged(value) {
    _isKeepLogged = value;
    notifyListeners();
  }

  Future<bool> submitForm(BuildContext context) async {


    if (_formState.currentState!.validate()) {
    _formState.currentState!.save();
      isLoading = true;

    fromData['deviceToken'] = await FirebaseMessaging.instance.getToken();
       try {

        UserModel user = await authService.signIn(fromData['email'],
            fromData['password'], fromData['deviceToken']);
        user.password = fromData['password'];
          final authProvider = Provider.of<AuthProvider>(context, listen: false);
        authProvider.user = user;
        if (isKeeplogged) {
          //Save to Prefs
          final prefs = await SharedPreferences.getInstance();
           prefs.setString('user',json.encode(user));
           prefs.setString('img',user.imgUrl.toString());

          }
         authProvider.authStatus = AuthStatus.isAuthenticated;
        return Future(() => true);
      } catch (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
        return Future(() => false);

      } finally {
        isLoading = false;
       }
    }else{
     return Future(() => false);
    }

  }
}
