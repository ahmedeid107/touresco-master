import 'package:flutter/material.dart';
import 'package:touresco/screens/sign_up/components/sign_up_form.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: ScreenConfig.getYByPercentScreen(0.05)),
            Image.asset(
              'assets/images/logo.png',
              width: ScreenConfig.getRuntimeWidthByRatio(160),
              height: ScreenConfig.getRuntimeHeightByRatio(160),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenConfig.getXByPerecentScreen(0.08),
                  top: ScreenConfig.getYByPercentScreen(0.05)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenConfig.getXByPerecentScreen(0.1)),
                child: Row(
                  children: [
                    Text(
                      lang!.signup,
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.normal,
                          fontSize: ScreenConfig.getFontDynamic(27)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: ScreenConfig.getYByPercentScreen(0.02),
            ),
              SignUpForm(),
          ],
        ),
      ),
    );
  }
}
