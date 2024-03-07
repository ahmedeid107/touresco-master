import 'package:touresco/services/service_collector.dart';

enum NotificationStatus {
  none,
  notSeen,
  seen,
}

class NotificationModel {
  final String id;
  NotificationStatus notficiationStatus;
  final String textEn;
  final String textAr;
  final String title;

  String get text =>
      ServiceCollector.getInstance().currentLanguage == 'en' ? textEn : textAr;
  final String tripId;
  final String path;
  final DateTime addedDate;

  NotificationModel({
    required this.id,
    required this.notficiationStatus,
    required this.textEn,
    required this.textAr,
    required this.title,
    required this.tripId,
    required this.path,
    required this.addedDate,
  });

  NotificationModel.fromJson(Map<String, dynamic> json)
      : id = json['Notification_Id'],
        notficiationStatus =
            getNotificationStatusFromJson(json['Notification_Status']),
        textEn = json['Notification_En_Text'],
        textAr = json['Notification_Ar_Text'],
        tripId = json['Notification_Trip_Id'],
        path = json['Notification_Path'],
        title = json['Notification_Owner_Name'],
        addedDate = DateTime.parse(
          json['Notification_DateAdded'],
        );

  static NotificationStatus getNotificationStatusFromJson(String data) {
    if (data == '2') {
      return NotificationStatus.seen;
    } else if (data == '1') {
      return NotificationStatus.notSeen;
    } else {
      return NotificationStatus.none;
    }
  }
}
