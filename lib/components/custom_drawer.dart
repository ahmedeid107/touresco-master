// ignore_for_file: constant_identifier_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:touresco/providers/auth_provider.dart';
import 'package:touresco/providers/language_provider.dart';
import 'package:touresco/providers/view_models/profile_view_model.dart';
import 'package:touresco/screens/dashboard_notfications/dashboardNotifications.dart';
import 'package:touresco/screens/main_nav/main_nav.dart';
import 'package:touresco/screens/sign_in/sign_in_screen.dart';
import 'package:touresco/services/app_exception.dart';
import 'package:touresco/utils/constants.dart';
import 'package:touresco/utils/screen_config.dart';
import 'package:http/http.dart' as http;

// constants
//-----------------------------------------------------------------
const double _custom_drawer_width_perc = 0.6;
const double _custom_drawer_header_height_perc = 0.18;
const double _custom_drawer_header_title_font_size = 20.0;
const double _custom_drawer_padding = 0.0;

//-----------------------------------------------------------------
class CustomDrawer extends StatefulWidget {
  static void logout(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).signOut().then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
    });
  }

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String availableTripAccount = "0";
  String bookedTripAccount = "0";

  // Functions
  Future<void> fetchAccountData() async {
    final url = Uri.parse(mainUrl);
    final Map<String, dynamic> postData = {
      'userID': Provider.of<AuthProvider>(context, listen: false).user.id,
      'Testaccount': '',
    };
    try {
      final res = await http.post(url, body: postData);
      if (res.statusCode == 200 && !res.body.isEmpty) {
        final mapData = json.decode(res.body) as Map;
        setState(() {
          availableTripAccount = mapData['available_trip_account'];
          bookedTripAccount = mapData['booked_trip_account'];
        });
      } else {
        throw AppException(AppExceptionData.serverNotRespond);
      }
    } on AppException catch (error) {
      throw error.toString();
    } catch (error) {
      throw AppException(AppExceptionData.unkown).toString();
    }
  }

  //-----------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width * _custom_drawer_width_perc,
      child: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(_custom_drawer_padding),
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  _custom_drawer_header_height_perc,
              child: DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          lang!.menu,
                          style: const TextStyle(
                              color: kCanvasColor,
                              fontSize: _custom_drawer_header_title_font_size),
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          Provider.of<AuthProvider>(context, listen: false)
                              .user
                              .fullName,
                          style: const TextStyle(
                              color: kCanvasColor,
                              fontSize:
                                  _custom_drawer_header_title_font_size - 8),
                        ),
                      ),
                    ],
                  )),
            ),
            ExpansionTile(
              onExpansionChanged: ((value) {
                if(value == true)
                fetchAccountData();
              } ),
              leading: Icon(
                Icons.account_balance_wallet_rounded,
                color: Colors.blueAccent,
              ),
              title: Text(lang.tripsBalance),
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.bookmark_add_outlined,
                      color: Colors.blueAccent[100]),
                  title: Row(
                    children: [
                      Expanded(child: Text(lang.available)),
                      Container(
                                           alignment: Alignment.center,
                        color: Colors.blueAccent[100],
                        width: 50,
                        child: Text(
                          availableTripAccount,
                          style:  const TextStyle(
                              letterSpacing: 0.1,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),                    ],
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading:
                      Icon(Icons.bookmark_added, color: Colors.blueAccent[100]),
                  title: Row(
                    children: [
                      Expanded(child: Text(lang.booked)),
                      Container(
                        alignment: Alignment.center,
                        color: Colors.blueAccent[100],
                        width: 50,
                        child: Text(
                          bookedTripAccount,
                          style:  const TextStyle(
                              letterSpacing: 0.1,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),                    ],
                  ),
                  onTap: () {},
                ),
              ],
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.blueAccent,
              ),
              title: Text(lang.updateProfileData),
              onTap: () {
                Navigator.pushNamed(context, '/update_profile_screen');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.payment,
                color: Colors.blueAccent,
              ),
              title: Text(lang.financialRecord),
              onTap: () {
                Navigator.pushNamed(context, '/finance_screen');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.archive,
                color: Colors.blueAccent,
              ),
              title: Text(lang.archive),
              onTap: () {
                Navigator.pushNamed(context, '/archive_sceen');
              },
            ),
            ExpansionTile(
              leading: Icon(
                Icons.notifications_sharp,
                color: Colors.blueAccent,
              ),
              title: Text(lang.notifications),
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.notifications_on,
                      color: const Color.fromARGB(100, 255, 193, 7)),
                  title:
                      Text(lang.tripsFinanical),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (c) {
                      return DashboardNotifications(
                        index: 2,
                      );
                    }));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.notifications_on,
                      color: const Color.fromARGB(100, 255, 193, 7)),
                  title: Text(lang.tripsChat),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (c) {
                      return DashboardNotifications(
                        index: 1,
                      );
                    }));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.notifications_on,
                      color: const Color.fromARGB(100, 255, 193, 7)),
                  title: Text(lang.trips),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (c) {
                      return DashboardNotifications(
                        index: 0,
                      );
                    }));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.notifications_on, color: Colors.amber),
                  title: Text(lang.notificationsGlobal),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (c) {
                      return MainNav(index: 3);
                    }));
                  },
                ),
              ],
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: Colors.blueAccent,
              ),
              title: Row(children: [
                Expanded(
                  child: Text(
                    lang.language,
                  ),
                ),
                Container(
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent[100],
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
            ListTile(
              leading: const Icon(
                Icons.exit_to_app_sharp,
                color: Colors.red,
              ),
              title: Text(lang.logout),
              onTap: () {
                CustomDrawer.logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
