
import 'package:flutter/material.dart';

class NotificationFilter extends StatelessWidget {
  const NotificationFilter(
      {Key? key,
        required this.value,
        required this.items,
        required this.onChanged})
      : super(key: key);

  final String value;
  final List<DropdownMenuItem<String>> items;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return   DropdownButton(
              underline: Container(),

              isExpanded: true,
              value: value,
              items: items,
              onChanged: onChanged );
  }
}
