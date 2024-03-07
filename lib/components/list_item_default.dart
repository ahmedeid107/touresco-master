import 'package:flutter/material.dart';

import 'package:touresco/utils/constants.dart';

class ListItemDefault extends StatelessWidget {
  const ListItemDefault(
      {Key? key,
      required this.leadingImg,
      required this.displayData,
      required this.onPressed,
      required this.actionIcon})
      : super(key: key);

  final String leadingImg;
  final Column displayData;
  final Function onPressed;
  final IconData actionIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(46, 70, 135, 225),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 3))
            ]),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: onPressed as void Function(),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(children: [
                Image.asset(
                  leadingImg,
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: displayData,
                ),
                Icon(
                  actionIcon,
                  color: kLightGreyColor,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
