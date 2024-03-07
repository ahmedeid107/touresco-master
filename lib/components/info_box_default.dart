import 'package:flutter/material.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';

class InfoBoxDefault extends StatelessWidget {
  const InfoBoxDefault(
      {Key? key,
      required this.text,
      required this.withAction,
      this.onPressed,
      required this.color,
      required this.buttonText,
      required this.icon})
      : super(key: key);

  final String text;
  final String buttonText;
  final IconData icon;
  final bool withAction;
  final Color color;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.symmetric(
          horizontal: ScreenConfig.getXByPerecentScreen(0.02)),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(
            icon,
            size: 27,
            color: Colors.white,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: Text(
            text,
            style: textTitle(Colors.white),
          )),
          const SizedBox(
            width: 5,
          ),
          if (withAction)
            TextButton(
                onPressed: onPressed as void Function(),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
                child: Text(
                  buttonText,
                  style: textTitle(kPrimaryColor),
                ))
        ],
      ),
    );
  }
}
