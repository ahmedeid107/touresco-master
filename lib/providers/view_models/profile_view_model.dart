import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touresco/providers/language_provider.dart';
import 'package:touresco/screens/sheets/language_selector_sheet.dart';
import 'package:touresco/services/app_language_service.dart';
import 'package:touresco/services/service_collector.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileViewModel with ChangeNotifier {
  Map<String, dynamic> _notificationMessenger = {
    'General_Notification': '0',
  };

  String get notificationCounter =>
      _notificationMessenger['General_Notification'];

  void syncNotificationProfile(String userId) async {
     _notificationMessenger = await ServiceCollector.getInstance()
        .metaDataService
        .syncProfileNotifications(userId);
    notifyListeners();
  }


  void showLanguageSelector(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return LanguageSelectorSheet(
            onPressed: (value) async {
              await AppLanguageService()
                  .updateLanguage(value); //update language in prefs

              ServiceCollector.getInstance().currentLanguage = value;

              Provider.of<LanguageProvider>(context, listen: false)
                  .currentLanguage = value;
              Navigator.pop(context);
            },
          );
        });
  }

  void showOwnerDashboard() async {
    String url = 'https://touresco.net/admin/material-rtl/login.php';
    final parsed = Uri.parse(url);

    if (await canLaunchUrl(parsed)) {
      if (Platform.isAndroid) {
        //In Android pdf should open inside pdfviewer
        await launchUrl(
          parsed,
          mode: LaunchMode.externalApplication,
        ); //To show pdf file using external application in phone that support .pdf
      } else if (Platform.isIOS) {
        await launchUrl(parsed);
      }
    }
  }

  void showPrivacyPolicy() async {
    String url = 'https://touresco.net/privacy-policy/';
    final parsed = Uri.parse(url);

    if (await canLaunchUrl(parsed)) {
      if (Platform.isAndroid) {
        //In Android pdf should open inside pdfviewer
        await launchUrl(parsed,
            mode: LaunchMode
                .inAppWebView); //To show pdf file using external application in phone that support .pdf
      } else if (Platform.isIOS) {
        await launchUrl(parsed);
      }
    }
  }
}
