import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/components/dashboard_button_default.dart';
import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/providers/language_provider.dart';
import 'package:touresco/providers/view_models/profile_view_model.dart';
import 'package:touresco/screens/sheets/change_password_dialog.dart';
import 'package:touresco/screens/sign_in/sign_in_screen.dart';
import 'package:touresco/utils/theme.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileActions extends StatefulWidget {
  const ProfileActions({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileActions> createState() => _ProfileActionsState();
}

class _ProfileActionsState extends State<ProfileActions>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance .removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<ProfileViewModel>(context, listen: false)
            .syncNotificationProfile(
                Provider.of<AuthProvider>(context, listen: false).user.id);
      },
    );
    return Consumer2<ProfileViewModel, LanguageProvider>(
      builder: (context, vm, languageProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lang!.dashboared,
              style: textTitle(kLightGreyColor),
            ),
            Padding(
                padding: EdgeInsets.only(
                  left: ScreenConfig.getRuntimeWidthByRatio(10),
                  right: ScreenConfig.getRuntimeWidthByRatio(10),
                  top: ScreenConfig.getYByPercentScreen(0.02),
                  bottom: ScreenConfig.getYByPercentScreen(0.02),
                ),
                child: Column(
                  children: [
                    // Booking
                    // DashboardButtonDefault(
                    //   text: lang.booking,
                    //   icon: Icons.book,
                    //   color: Colors.red,
                    //   onPressed: () {
                    //     Navigator.pushNamed(context, '/take_role_screen');
                    //   },
                    // ),

                    SizedBox(
                      height: ScreenConfig.getYByPercentScreen(0.01),
                    ),

/*
                    // Transferred trips
                    DashboardButtonDefault(
                      text: lang.transferredTrips,
                      icon: Icons.trip_origin,
                      color: Colors.cyan,
                      onPressed: () {
                        Navigator.pushNamed(
                            context, '/transferred_trips_screen');
                      },
                    ),
                    SizedBox(
                      height: ScreenConfig.getYByPercentScreen(0.01),
                    ),*/

                    //notifications
                    // DashboardButtonDefault(
                    //   text: lang.notifications,
                    //   icon: Icons.notifications,
                    //   color: Colors.indigoAccent,
                    //   isWithNotificationStyle: vm.notificationCounter != '0',
                    //   notificationText: vm.notificationCounter,
                    //   notificationBackgroundColor: Colors.red,
                    //   notifcationIcon: Icons.notification_add,
                    //   onPressed: () {
                    //     Navigator.of(context)
                    //         .pushNamed('/notifications_screen')
                    //         .then((value) {
                    //
                    //     });
                    //   },
                    // ),
                    // SizedBox(
                    //   height: ScreenConfig.getYByPercentScreen(0.01),
                    // ),

                    //Payments
                    DashboardButtonDefault(
                      text: lang.payments,
                      icon: Icons.payment,
                      color: kPrimaryColor,
                      onPressed: () {
                        Navigator.pushNamed(context, '/finance_screen');
                      },
                    ),
                    SizedBox(
                      height: ScreenConfig.getYByPercentScreen(0.01),
                    ),

                    //Groups
                    SizedBox(
                      height: ScreenConfig.getYByPercentScreen(0.01),
                    ),

                    // Archive
                    DashboardButtonDefault(
                      text: lang.archive,
                      icon: Icons.archive,
                      color: Colors.orange,
                      onPressed: () {
                        Navigator.pushNamed(context, '/archive_sceen');
                      },
                    ),

                    SizedBox(
                      height: ScreenConfig.getYByPercentScreen(0.01),
                    ),

                    //Change Password
                    DashboardButtonDefault(
                      text: lang.changePassword,
                      icon: Icons.password,
                      color: Colors.lime,
                      onPressed: () {
                        showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (context) {
                              return const ChangePasswordDialog();
                            }).then((msg) {
                          if (msg != null) {

                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(msg)));
                          }
                        });
                      },
                    ),

                    SizedBox(
                      height: ScreenConfig.getYByPercentScreen(0.01),
                    ),

                    // Change Profile Data
                    DashboardButtonDefault(
                      text: lang.updateProfileData,
                      icon: Icons.person,
                      color: Colors.blueAccent,
                      onPressed: () {
                        Navigator.pushNamed(context, '/update_profile_screen');
                      },
                    ),

                    // SizedBox(
                    //   height: ScreenConfig.getYByPercentScreen(0.01),
                    // ),

                    // Owner Dashboard
                    // DashboardButtonDefault(
                    //   text: lang.ownerDashboard,
                    //   icon: Icons.person,
                    //   color: Colors.lightBlueAccent,
                    //   onPressed: () {
                    //     vm.showOwnerDashboard();
                    //   },
                    // ),

                    SizedBox(
                      height: ScreenConfig.getYByPercentScreen(0.01),
                    ),

                    // Language
                    DashboardButtonDefault(
                      text: lang.language,
                      icon: Icons.settings,
                      color: Colors.yellow,
                      isWithNotificationStyle: true,
                      notificationText:
                          languageProvider.currentLanguage.toUpperCase(),
                      notificationBackgroundColor: Colors.orange,
                      notifcationIcon: Icons.language,
                      onPressed: () {
                        Provider.of<ProfileViewModel>(context, listen: false)
                            .showLanguageSelector(context);
                      },
                    ),

                    SizedBox(
                      height: ScreenConfig.getYByPercentScreen(0.01),
                    ),

                    //Privacy Policy
                    DashboardButtonDefault(
                      text: lang.privacy,
                      icon: Icons.policy,
                      color: Colors.grey,
                      onPressed: () {
                        vm.showPrivacyPolicy();
                      },
                    ),
                  ],
                )),
            Text(
              lang.account,
              style: textTitle(kLightGreyColor),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: ScreenConfig.getRuntimeWidthByRatio(10),
                right: ScreenConfig.getRuntimeWidthByRatio(10),
                top: ScreenConfig.getYByPercentScreen(0.02),
                bottom: ScreenConfig.getYByPercentScreen(0.02),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*
                  TextButton(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    onPressed: () {},
                    child: Text(
                      lang.deleteAccount,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ButtonStyle(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding:
                          MaterialStateProperty.all(EdgeInsetsDirectional.zero),
                      minimumSize: MaterialStateProperty.all(Size.zero),
                      foregroundColor: MaterialStateProperty.all(Colors.red),
                      overlayColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.red.withOpacity(0.1)),
                    ),
                  ),
                  */
                  SizedBox(
                    height: ScreenConfig.getYByPercentScreen(0.01),
                  ),
                  TextButton(
                    onPressed: () => logout(context),
                    child: Text(
                      lang.logout,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ButtonStyle(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding:
                          MaterialStateProperty.all(EdgeInsetsDirectional.zero),
                      minimumSize: MaterialStateProperty.all(Size.zero),
                      foregroundColor: MaterialStateProperty.all(Colors.red),
                      overlayColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.red.withOpacity(0.1)),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  //Functions
 static void logout(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).signOut().then((value) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) =>SignInScreen() ));

    });

 }
}
