import 'package:flutter/material.dart';
import 'package:touresco/models/notification_model.dart';
import 'package:touresco/services/service_collector.dart';

class NotificationsViewModel with ChangeNotifier {
  List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications => [..._notifications];
  List<NotificationModel> _searchedNotificationModel = []; //
  List<NotificationModel> get searchedNotifications =>
      [..._searchedNotificationModel];

  var loading = false;

  String searchText = "";
  Map<String, bool> deletedNotificationsId = {};

  String _filter = 'select';

  String get filter => _filter;

  set filter(value) {
    _filter = value;
    notifyListeners();
  }

  final List<DropdownMenuItem<String>> filterItems = [
    DropdownMenuItem(
        value: 'select',
        child: Text(ServiceCollector.getInstance().currentLanguage == 'en'
            ? 'Select to present results'
            : 'اختر لعرض النتائج')),
    DropdownMenuItem(
        value: 'dues',
        child: Text(ServiceCollector.getInstance().currentLanguage == 'en'
            ? 'Your dues'
            : 'دائن')),
    DropdownMenuItem(
        value: 'requiredToPay',
        child: Text(ServiceCollector.getInstance().currentLanguage == 'en'
            ? 'Required to pay'
            : 'مدين')),
  ];
  var items = [
    'select',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  Future syncNotification(String userId, String type) async {
    loading = true;
    _notifications = await ServiceCollector.getInstance()
        .metaDataService
        .syncNotifications(userId, type);
    loading = false;

    notifyListeners();
  }

  Future syncNotificationSeen(String notificationId) async {
    ServiceCollector.getInstance()
        .metaDataService
        .syncNotificationsSeen(notificationId);
    notifyListeners();
  }

  void searchForTrips(String text,String userId) {
    _searchedNotificationModel.clear();


    if (text.isEmpty) {
      notifyListeners();
      return;
    }

    searchText = text;
    String lang = ServiceCollector.getInstance().currentLanguage;

    _searchedNotificationModel
        .addAll(_notifications.where((element) => lang == 'ar'
            ? element.textAr.contains(text)
            : false || lang == 'en'
                ? element.textEn.contains(text)
                : false || element.addedDate.toString().contains(text)));
     notifyListeners();
  }

  void deletedNotifications(String id) {
    if (deletedNotificationsId.containsKey(id)) {
      deletedNotificationsId[id] = !deletedNotificationsId[id]!;
    } else {
      deletedNotificationsId[id] = true;
    }
    notifyListeners();
  }

  bool isSelected = false;

  void changeIsSelected() {
    deletedNotificationsId.clear();
    isSelected = !isSelected;
    notifyListeners();
  }

  Future<void> deleteNotificationsButton(String userId, String type) async {
    List<String> list = [];
    deletedNotificationsId.forEach((key, value) {
      if (value) {
        list.add("$key");
      }
    });
    ServiceCollector.getInstance()
        .metaDataService
        .deleteNotifications(userId, list);

    syncNotification(userId, type);
    changeIsSelected();
  }
}
