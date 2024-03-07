import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/providers/view_models/notifications_view_model.dart';

import 'package:touresco/screens/main_nav/explore/explore_nav.dart';
import 'package:touresco/screens/main_nav/profile/profile_nav.dart';
import 'package:touresco/screens/main_nav/transferred_trips_nav/transferred_trips_nav.dart';
import 'package:touresco/screens/main_nav/trips/trips_nav.dart';
import 'package:touresco/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../providers/auth_provider.dart';
import '../../providers/view_models/take_role_view_model.dart';
import 'notification/notification_page.dart';

class MainNav extends StatefulWidget {
  int index;

  MainNav({this.index = 0});

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _currentIndex = 0;
  final mainNavPages = [
    const ExploreNav(),
    const TransferredTripsNav(),
    const TripsNav(),
    const NotificationPage(),
    const ProfileNav(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    _currentIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);

    return Scaffold(
      appBar: getAppBarDependOnScreen(_currentIndex, lang!),
      resizeToAvoidBottomInset: false,
      body: PopScope(
          onPopInvoked: (canPop) async {
            String userId =
                Provider.of<AuthProvider>(context, listen: false).user.id;
            WidgetsBinding.instance.addPostFrameCallback(
              (timeStamp) {
                Provider.of<TakeRoleViewModel>(context, listen: false)
                    .checkRoleStatus(userId);
                Provider.of<TakeRoleViewModel>(context, listen: false)
                    .syncNotificationProfileNew(userId);
                Provider.of<TakeRoleViewModel>(context, listen: false).numOfMessages=0;
                Provider.of<TakeRoleViewModel>(context, listen: false)
                    .syncGroupNumber(userId);

              },
            );
            Navigator.pop(context);
          },
          child: mainNavPages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: kLightGreyColor,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.swipe_left_outlined),
            activeIcon: Icon(Icons.swipe_left),
          ),
          //    BottomNavigationBarItem(label: 'Search', icon: Icon(Icons.search)),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.drive_eta_outlined),
            activeIcon: Icon(Icons.drive_eta),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.notifications_outlined),
            activeIcon: Icon(Icons.notifications),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person),
          ),
        ],
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }

  AppBar? getAppBarDependOnScreen(int index, AppLocalizations lang) {
    if (index == 1) {
      return AppBar(
        automaticallyImplyLeading: false,
        title: Text(lang.mytransferFlights),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: () {
                  String userId =
                      Provider.of<AuthProvider>(context, listen: false).user.id;
                  Provider.of<TakeRoleViewModel>(context, listen: false)
                      .syncNotificationProfileNew(userId);
                  Provider.of<TakeRoleViewModel>(context, listen: false)
                      .checkRoleStatus(Provider.of<AuthProvider>(context, listen: false).user.id);

                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.dashboard,
                )),
          )
        ],
      );
    } else if (index == 2){
      return AppBar(
        automaticallyImplyLeading: false,
        title: Text(lang.myPrivateTrips),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: () {
                  String userId =
                      Provider.of<AuthProvider>(context, listen: false).user.id;
                  Provider.of<TakeRoleViewModel>(context, listen: false)
                      .syncNotificationProfileNew(userId);
                  Provider.of<TakeRoleViewModel>(context, listen: false)
                      .checkRoleStatus(Provider.of<AuthProvider>(context, listen: false).user.id);

                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.dashboard,
                )),
          )
        ],
      );
    } else if (index == 3){
      Provider.of<NotificationsViewModel>(context, listen: false)
          .deletedNotificationsId
          .clear();
      Provider.of<NotificationsViewModel>(context, listen: false)
          .searchedNotifications
          .clear();
      Provider.of<NotificationsViewModel>(context, listen: false)
          .notifications
          .clear();
      Provider.of<NotificationsViewModel>(context, listen: false)
          .syncNotification(
              Provider.of<AuthProvider>(context, listen: false).user.id, "");
      return null;
    }else if(index == 4){
      return AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: () {
                  String userId =
                      Provider.of<AuthProvider>(context, listen: false).user.id;
                  Provider.of<TakeRoleViewModel>(context, listen: false)
                      .syncNotificationProfileNew(userId);
                  Provider.of<TakeRoleViewModel>(context, listen: false)
                      .checkRoleStatus(Provider.of<AuthProvider>(context, listen: false).user.id);

                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.dashboard,
                )),
          )
        ],
      );
    } else {
      return null;
    }
  }
}
