import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:touresco/utils/screen_config.dart';

class SocialButtonCircle extends StatelessWidget {
  const SocialButtonCircle(
      {Key? key, required this.path, required this.onpress})
      : super(key: key);

  final String path;
  final Function onpress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress as void Function(),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(46, 70, 135, 225),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3))
            ]),
        width: ScreenConfig.getRuntimeWidthByRatio(30),
        height: ScreenConfig.getRuntimeHeightByRatio(30),
        child: SvgPicture.asset(path),
      ),
    );
  }
}
