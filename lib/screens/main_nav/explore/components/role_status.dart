import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:touresco/providers/trips_provider.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RoleStatus extends StatelessWidget {
  const RoleStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);

    return FutureBuilder(
      future: Provider.of<TripsProvider>(context, listen: false)
          .syncCurrentRole(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Provider.of<TripsProvider>(context, listen: false)
                  .userHavePublicRole
              ? _buildUserHaveRole(lang, context)
              : _buildUserNotHaveRole(lang, context);
        } else {
          return Container();
        }
      },
    );
  }

  Column _buildUserNotHaveRole(AppLocalizations? lang, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: ScreenConfig.getYByPercentScreen(0.02),
        ),
        SizedBox(
          height: 300,
          width: 300,
          child: Lottie.asset(
            'assets/animations/lottie_yoga.json',
            repeat: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenConfig.getXByPerecentScreen(0.05)),
          child: Text(
            lang!.noUserTripsMsg,
            style: textTitle(kNormalTextColor)
                .copyWith(fontSize: ScreenConfig.getFontDynamic(14)),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: ScreenConfig.getYByPercentScreen(0.04),
        ),
      ],
    );
  }

  Column _buildUserHaveRole(AppLocalizations? lang, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: ScreenConfig.getYByPercentScreen(0.02),
        ),
        SizedBox(
          height: 300,
          width: 300,
          child: Lottie.asset(
            'assets/animations/lottie_yoga.json',
            repeat: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenConfig.getXByPerecentScreen(0.05)),
          child: Text(
            lang!.currentRole,
            style: textTitle(kPrimaryColor)
                .copyWith(fontSize: ScreenConfig.getFontDynamic(30)),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: ScreenConfig.getYByPercentScreen(0.04),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenConfig.getXByPerecentScreen(0.05)),
          child: Text(
            Provider.of<TripsProvider>(context, listen: false).userRole,
            style: textTitle(Colors.red)
                .copyWith(fontSize: ScreenConfig.getFontDynamic(25)),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
