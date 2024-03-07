import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            '© Copyright TechTent',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          ),
          /*
          SizedBox(width: ScreenConfig.getXByPerecentScreen(0.02)),
          SocialButtonCircle(
            onpress: () {},
            path: 'assets/images/icon_facebook.svg',
          ),
          SizedBox(width: ScreenConfig.getXByPerecentScreen(0.02)),
          SocialButtonCircle(
            onpress: () {},
            path: 'assets/images/icon_insta.svg',
          )
          */
        ],
      ),
    );
  }
}
