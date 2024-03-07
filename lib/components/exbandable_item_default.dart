import 'package:flutter/material.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';

class ExpandableItemDefault extends StatelessWidget {
  const ExpandableItemDefault(
      {Key? key,
      required this.mainTitle,
      required this.isCurrentExpand,
      required this.expandableWidget,
      required this.reverseExpandableList,
      this.showExpandIcon = true})
      : super(key: key);

  final String mainTitle;
  final bool isCurrentExpand;
  final Widget expandableWidget;
  final Function reverseExpandableList;
  final bool showExpandIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
              color: Color.fromRGBO(46, 70, 135, 225),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3))
        ],
      ),
      margin: EdgeInsets.symmetric(
          horizontal: ScreenConfig.getXByPerecentScreen(0.02)),
      padding: EdgeInsets.symmetric(
          horizontal: ScreenConfig.getXByPerecentScreen(0.04)),
      child: Column(
        children: [
          const SizedBox(height: 10,),

          GestureDetector(
            onTap: reverseExpandableList as void Function(),
            child: Container(
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    mainTitle,
                    style: textTitle(kTitleBlackTextColor),
                  ),
                  if (showExpandIcon)
                    isCurrentExpand
                        ? const Icon(
                            Icons.arrow_circle_down,
                            color: kPrimaryColor,
                          )
                        : const Icon(
                            Icons.arrow_circle_up,
                            color: kPrimaryColor,
                          )
                ],
              ),
            ),
          ),
          if (isCurrentExpand) expandableWidget ,
          const SizedBox(height: 10,),

        ],
      ),
    );
  }
}
