import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:touresco/Interfaces/i_auth.dart';
import 'package:touresco/models/user_model.dart';

import 'language_provider.dart';

enum AuthStatus {
  isAuthenticated,
  notAuthennticated,
}

class AuthProvider with ChangeNotifier {
  final IAuth authService;

  AuthProvider({required this.authService});

  AuthStatus _authStatus = AuthStatus.notAuthennticated;

  AuthStatus get authStatus => _authStatus;

  set authStatus(value) {
    _authStatus = value;
    notifyListeners();
  }

  // ignore: avoid_init_to_null

  late UserModel _user;

  UserModel get user => _user;

  set user(final UserModel value) {
    _user = value;
    notifyListeners();
  }

  Future<void> syncUserIfExist(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    final img = prefs.getString('img');
    if (userData == null) {
      _authStatus = AuthStatus.notAuthennticated;
       return;
    }

    // getting user data from prefs

    UserModel user = UserModel.fromJson(json.decode(userData));
    user.imgUrl = img;
     String? deviceToken;

    deviceToken = await FirebaseMessaging.instance.getToken();
     if (deviceToken == null) return;
    try {
      await authService.signIn(
        // sign in with saved user data
        user.email,
        user.password!,
        deviceToken,
      );
       Provider.of<AuthProvider>(context, listen: false).user = user;


      _authStatus = AuthStatus.isAuthenticated;

    } catch (error) {
      _authStatus = AuthStatus.notAuthennticated;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text((error as String))));
    }
  }

  Future<String> deleteAccount({
    required BuildContext context,
    required String password,
  }) async {


    try {
        if (password ==user.password ) {
          var result = await authService.deleteAccount(
            token: user.id,
            password: password,
          );
            var statusCode = result['Status'].toString();
           return statusCode;
        } else {
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text((Provider.of<LanguageProvider>(context, listen: false)
                .currentLanguage ==
                "en"
                ? "Please enter a password"
                : "يرجى ادخال كلمة مرور صحيحة")),
            backgroundColor: Colors.red.shade300,
          ));
          return "null";
        }

    } catch (error) {
        ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text((error as String))));

    }
    return "null";

  }

  Future<void> signOut() async {
    await authService.signOut();
    authStatus = AuthStatus.notAuthennticated;
    notifyListeners();
  }



}
