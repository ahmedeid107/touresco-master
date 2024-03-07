import 'package:flutter/material.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';

class DashboardButtonDefault extends StatelessWidget {
  const DashboardButtonDefault({
    Key? key,
    required this.color,
    required this.text,
    required this.icon,
    this.isWithNotificationStyle = false,
    this.notificationBackgroundColor = Colors.red,
    this.notificationText = "",
    this.notifcationIcon,
    required this.onPressed,
  }) : super(key: key);

  final Color color;
  final String text;
  final IconData icon;
  final bool isWithNotificationStyle;
  final Color notificationBackgroundColor;
  final String notificationText;
  final IconData? notifcationIcon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: onPressed as void Function(),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 4),
              child: CircleAvatar(
                radius: ScreenConfig.getFontDynamic(25),
                backgroundColor: color,
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            ),
             SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: textTitle(kTitleBlackTextColor),
              ),
            ),

            isWithNotificationStyle
                ? Container(
                    width: 60,
                    height: 30,
                    decoration: BoxDecoration(
                      color: notificationBackgroundColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Center(
                            child: Text(
                              notificationText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenConfig.getFontDynamic(12),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Center(
                            child: Icon(
                              notifcationIcon,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : const Icon(
                    Icons.arrow_right,
                    color: kLightGreyColor,
                  )
          ],
        ),
      ),
    );
  }
}
