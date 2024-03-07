import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/screens/main_nav/main_nav.dart';
import '../providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

     Provider.of<AuthProvider>(context, listen: false)
        .syncUserIfExist(context).then((value) {
            Timer(Duration(seconds: 2), () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MainNav()));
            });
     });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.brown,
    );
  }
}
