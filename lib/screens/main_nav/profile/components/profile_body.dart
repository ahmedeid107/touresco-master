import 'package:flutter/material.dart';
import 'package:touresco/screens/main_nav/profile/components/profile_actions.dart';
import 'package:touresco/screens/main_nav/profile/components/user_display.dart';
import 'package:touresco/utils/screen_config.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenConfig.getRuntimeWidthByRatio(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const SizedBox(height: 8,),
            const UserDisplay(),
            SizedBox(
              height: ScreenConfig.getYByPercentScreen(0.03),
            ),
            const ProfileActions(),
          ],
        ),
      ),
    );
  }
}
