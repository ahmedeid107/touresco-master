import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/providers/view_models/profile_view_model.dart';
import 'package:touresco/screens/main_nav/profile/components/profile_body.dart';

class ProfileNav extends StatelessWidget {
  const ProfileNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: ProfileViewModel(),
        child:   ProfileBody(),
    );
  }
}
