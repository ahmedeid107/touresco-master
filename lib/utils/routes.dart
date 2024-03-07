import 'package:flutter/material.dart';
import 'package:touresco/screens/archive/archive_screen.dart';
import 'package:touresco/screens/chat/chat_screen.dart';

import 'package:touresco/screens/finance/finance_screen.dart';
import 'package:touresco/screens/finance_details/finance_details_screen.dart';
import 'package:touresco/screens/forget_password/forget_password_sceen.dart';
import 'package:touresco/screens/groups/groups_screen.dart';
import 'package:touresco/screens/main_nav/main_nav.dart';
 import 'package:touresco/screens/sign_in/sign_in_screen.dart';
import 'package:touresco/screens/sign_up/sign_up_screen.dart';
import 'package:touresco/screens/take_role/take_role_screen.dart';
import 'package:touresco/screens/trip_details/trip_details_screen.dart';
import 'package:touresco/screens/update_profile/update_profile_screen.dart';

import '../screens/groups/groupe_screen_chat.dart';

final Map<String, WidgetBuilder> routes = {
  '/sign_in_screen': (context) => const SignInScreen(),
  '/GroupScreenChat': (context) => const GroupScreenChat(),
  '/sign_up_screen': (context) => const SignUpScreen(),
  '/forget_password_screen': (context) => const ForgetPasswordScreen(),
  '/main_nav': (context) =>   MainNav(),
  '/trip_details_screen': (context) =>   TripDetailsScreen(),
  '/take_role_screen': (context) => const TakeRoleScreen(),
  '/finance_screen': (context) => const FinanceScreen(),
  '/finance_details_screen': (context) => const FinanceDetailsScreen(),
  '/archive_sceen': (context) =>   ArchiveScreen(),
  '/chat_screen': (context) =>  ChatScreen(),
  '/groups_screen': (context) => const GroupsScreen(),
  // '/notifications_screen': (context) => const NotificationsScreen(),
  '/update_profile_screen': (context) => const UpdateProfileScreen(),
};
