import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:touresco/components/default_button.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPasswordCompleted extends StatelessWidget {
  const ForgetPasswordCompleted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return Column(
      children: [
        SizedBox(
          height: ScreenConfig.getYByPercentScreen(0.07),
        ),
        SizedBox(
          height: 200,
          child: Lottie.asset('assets/animations/lottie_emailSent1.json',
              repeat: true),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            lang!.weHaveSentPasswordRecovery,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
                fontSize: ScreenConfig.getFontDynamic(18)),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DefaultButton(
              buttonWidth: double.infinity,
              buttonText: lang.back,
              onpressed: () {
                Navigator.of(context).pop();
              }),
        )
      ],
    );
  }
}
