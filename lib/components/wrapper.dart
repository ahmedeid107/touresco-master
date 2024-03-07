import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/screens/dashbord/dashbord.dart';
import 'package:touresco/screens/sign_in/sign_in_screen.dart';

class Wrappr extends StatelessWidget {
  const Wrappr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return FutureBuilder(
      future: Provider.of<AuthProvider>(context, listen: false).syncUserIfExist(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              if (authProvider.authStatus == AuthStatus.isAuthenticated) {
                return Dashbord();
              } else {
                return const SignInScreen();
              }
            },
          );
        } else {
          return const Scaffold();
        }
      },
    );
  }
}
