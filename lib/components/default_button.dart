import 'package:flutter/material.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';

class DefaultButton extends StatelessWidget {
  final String buttonText;
  final double buttonWidth;
  final Function onpressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double elevation;

    DefaultButton(
      {Key? key,
      required this.buttonWidth,
      required this.buttonText,
      required this.onpressed,
      this.backgroundColor = kPrimaryColor,
      this.textColor = Colors.white,
      this.elevation  = 4
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenConfig.getRuntimeWidthByRatio(buttonWidth),
      height: ScreenConfig.getRuntimeHeightByRatio(52),
      child: TextButton(
        onPressed: () => onpressed(),
        child: Text(
          buttonText,
          style: TextStyle(
              color: textColor, fontSize: ScreenConfig.getFontDynamic(14)),
        ),
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
