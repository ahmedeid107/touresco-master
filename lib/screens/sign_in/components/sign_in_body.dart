import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/providers/language_provider.dart';
import 'package:touresco/providers/view_models/profile_view_model.dart';
import 'package:touresco/screens/sign_in/components/footer.dart';
import 'package:touresco/screens/sign_in/components/sign_in_form.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: constraints.copyWith(
                minHeight: constraints.maxHeight, maxHeight: double.infinity),
            child: IntrinsicHeight(
              child: Column(
                children: [

                  ListTile(
                    title: Row(children: [
                      Container(
                        width: 60,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 68, 145, 201),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Center(
                                child: Text(
                                  Provider.of<LanguageProvider>(context,
                                          listen: false)
                                      .currentLanguage
                                      .toUpperCase(),
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
                                  Icons.language,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ]),
                    onTap: () {
                      Provider.of<ProfileViewModel>(context, listen: false)
                          .showLanguageSelector(context);
                    },
                  ),



                  SizedBox(height: ScreenConfig.getYByPercentScreen(0.05)),
                  Image.asset(
                    'assets/images/logo.png',
                    width: ScreenConfig.getRuntimeWidthByRatio(260),
                    height: ScreenConfig.getRuntimeHeightByRatio(260),
                  ),
                  SizedBox(height: ScreenConfig.getYByPercentScreen(0.02)),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                ScreenConfig.getXByPerecentScreen(0.08)),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            lang!.welcome,
                            style: TextStyle(
                                color: kTitleBlackTextColor,
                                fontWeight: FontWeight.w700,
                                fontSize: ScreenConfig.getFontDynamic(27)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                ScreenConfig.getXByPerecentScreen(0.09)),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            lang.loginWithAccount,
                            style: TextStyle(
                                color: kTitleBlackTextColor,
                                fontSize: ScreenConfig.getFontDynamic(14)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenConfig.getYByPercentScreen(0.01)),
                    SignInForm(),
                  Container(
                    margin: EdgeInsets.only(
                      top: 20,
                      left: ScreenConfig.getXByPerecentScreen(0.08),
                      right: ScreenConfig.getXByPerecentScreen(0.08),
                    ),
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        Text(
                          lang.dontHaveAccount,
                          style: TextStyle(
                              color: kNormalTextColor,
                              fontSize: ScreenConfig.getFontDynamic(14)),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        InkWell(
                          onTap: () {
                            navigateToSignUpScreen(context);
                          },
                          child: Text(
                            lang.signupHere,
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: ScreenConfig.getFontDynamic(14),
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Expanded(
                      child: Align(
                          alignment: Alignment.bottomCenter, child: Footer()))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void navigateToSignUpScreen(BuildContext context) {
    Navigator.of(context).pushNamed('/sign_up_screen');
  }
}
