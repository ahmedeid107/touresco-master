import 'package:flutter/material.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageSelectorSheet extends StatelessWidget {
  const LanguageSelectorSheet({Key? key, required this.onPressed})
      : super(key: key);
  final Function(String value) onPressed;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      height: ScreenConfig.getYByPercentScreen(0.4),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(21.0),
          topRight: Radius.circular(21.0),
        ),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          lang!.selectLanguage,
          style: textTitle(kPrimaryColor),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () => onPressed('en'),
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: ScreenConfig.getXByPerecentScreen(0.1)),
            alignment: Alignment.center,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: kLightGreyColor)),
            width: double.infinity,
            child: Text(
              'English',
              style: textTitle(kTitleBlackTextColor),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () => onPressed('ar'),
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: ScreenConfig.getXByPerecentScreen(0.1)),
            alignment: Alignment.center,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: kLightGreyColor)),
            width: double.infinity,
            child: Text(
              'العربية',
              style: textTitle(kTitleBlackTextColor),
            ),
          ),
        )
      ]),
    );
  }
}
