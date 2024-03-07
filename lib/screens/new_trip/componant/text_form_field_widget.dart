import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget({
    Key? key,
    required this.controller,
    required this.hint,
    this.icon,
    this.type = TextInputType.text,
    this.isMulti = false,
    this.isEnable = true,
  }) : super(key: key);

  TextEditingController controller;
  String hint;
  IconData? icon;
  TextInputType type;

  bool isMulti;
  bool isEnable;

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey[300]!)]),
      padding: icon != null
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        enabled: isEnable,
        controller: controller,
        keyboardType: type,
        minLines: 1,
        maxLines: isMulti ? 3 : 1,
        decoration: InputDecoration(
            counter: Container(),
            border: InputBorder.none,
            hintText: hint,
            prefixIcon: icon != null
                ? Icon(
                    icon,
                  )
                : null,
            hintStyle: TextStyle(
              color: Colors.grey[400]
            ),
        ),
        validator: (value) {
          if (value?.isEmpty == true) {
            return lang.thisFieldIsRequired;
          }
          return null;
        },
      ),
    );
  }
}
