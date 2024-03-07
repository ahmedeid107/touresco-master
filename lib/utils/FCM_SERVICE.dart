import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../screens/dashboard_notfications/dashboardNotifications.dart';
import 'navigation.dart';

class Initialization {
  static Future<void> initFirebaseMessaging() async {
    await _setupFlutterLocalNotificationsPlugin();
    await _setupFirebaseMessagingConfigs();
  }
}

var dData = {};

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.',
  importance: Importance.max,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

bool isFlutterLocalNotificationsInitialized = false;

Future<void> _setupFlutterLocalNotificationsPlugin() async {
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  var initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = DarwinInitializationSettings();
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (notificationResponse) async {

    if (dData['type'] == "chat") {
      // NavigationService.navigatorKey.currentState!.pushNamed(
      //   '/chat_screen',
      //   arguments: {
      //     'userId': dData['userId'].toString(),
      //     'officeId': dData['officeId'].toString(),
      //     'title': dData['title'].toString(),
      //     'type': '0',
      //     'tripSource': dData['tripSource'].toString(),
      //     'isPrivate': dData['isPrivate'].toString() == "true",
      //   },
      // );
      Navigator.push(NavigationService.navigatorKey.currentContext!,
            MaterialPageRoute(builder: (context) {
          return DashboardNotifications(
            index: 1,
          );
        }));

    } else if (dData['type'] == "travel") {
      Navigator.push(NavigationService.navigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) {
            return DashboardNotifications(
              index: 0,
            );
          }));
      // NavigationService.navigatorKey.currentState!
      //     .pushNamed('/trip_details_screen', arguments: {
      //       'id': dData['tripId'].toString(),
      //       'path': dData['path'].toString(),
      //       'type': dData['expandableType'].toString(),
      //     })
      //     .then((value) {})
      //     .catchError(
      //       (onError) {},
      //     );
    } else if (dData['type'] == "finance") {
      Navigator.push(NavigationService.navigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) {
            return DashboardNotifications(
              index: 2,
            );
          }));
      // NavigationService.navigatorKey.currentState!.pushNamed(
      //   '/finance_details_screen',
      //   arguments: {
      //     'id': dData["officeId"].toString(),
      //     'title': dData["title"].toString(),
      //     'tripSource': dData["path"],
      //     'type': dData['expandableType'].toString(),
      //   },
      // ).then(
      //   (value) {},
      // );
    } else {
      Navigator.push(NavigationService.navigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) {
            return DashboardNotifications(
              index: 0,
            );
          }));
      // Navigator.push(NavigationService.navigatorKey.currentContext!,
      //     MaterialPageRoute(builder: (context) {
      //   return MainNav(
      //     index: 3,
      //   );
      // }));
    }
  });

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  isFlutterLocalNotificationsInitialized = true;
}

Future<void> _setupFirebaseMessagingConfigs() async {
  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission();

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((remoteMessage) {
      showFlutterNotification(message: remoteMessage);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      AppleNotification? ios = message.notification?.apple;

      if (notification != null && (android != null || ios != null)) {
        var data = message.data;
        if (data['type'] == "chat") {
          Navigator.push(NavigationService.navigatorKey.currentContext!,
              MaterialPageRoute(builder: (context) {
                return DashboardNotifications(
                  index: 1,
                );
              }));
          // NavigationService.navigatorKey.currentState!.pushNamed(
          //   '/chat_screen',
          //   arguments: {
          //     'userId': data['userId'].toString(),
          //     'officeId': data['officeId'].toString(),
          //     'title': data['title'].toString(),
          //     'type': '0',
          //     'tripSource': data['tripSource'].toString(),
          //     'isPrivate': data['isPrivate'].toString() == "true",
          //   },
          // );
        } else if (data['type'] == "travel") {
          Navigator.push(NavigationService.navigatorKey.currentContext!,
              MaterialPageRoute(builder: (context) {
                return DashboardNotifications(
                  index: 0,
                );
              }));
          // NavigationService.navigatorKey.currentState!
          //     .pushNamed('/trip_details_screen', arguments: {
          //       'id': data['tripId'].toString(),
          //       'path': data['tripSource'].toString(),
          //     })
          //     .then((value) {})
          //     .catchError(
          //       (onError) {},
          //     );
        }
        else if (data['type'] == "finance") {
          Navigator.push(NavigationService.navigatorKey.currentContext!,
              MaterialPageRoute(builder: (context) {
                return DashboardNotifications(
                  index: 2,
                );
              }));
          // NavigationService.navigatorKey.currentState!.pushNamed(
          //   '/finance_details_screen',
          //   arguments: {
          //     'id': data["officeId"].toString(),
          //     'title': data["title"].toString(),
          //     'tripSource': data["tripSource"],
          //   },
          // ).then(
          //   (value) {},
          // );
        }
      }
    });

    FirebaseMessaging.onBackgroundMessage(
      _firebaseMessagingBackgroundHandler,
    );
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage remoteMessage) async {
  await Firebase.initializeApp();
  await _setupFlutterLocalNotificationsPlugin();
  //  showFlutterNotification(message: remoteMessage);
}

void showFlutterNotification(
    {RemoteMessage? message, String? title, String? body}) {
  assert(message != null && (title == null && body == null));
  RemoteNotification? notification = message!.notification;
  AndroidNotification? android = message.notification?.android;

  AppleNotification? ios = message.notification?.apple;
  dData = message.data;

  if (notification != null && (android != null || ios != null)) {
    print("ADSSADASD SAD AS   ${message.data}");
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            playSound: true,
            channelShowBadge: true,
            icon: "@mipmap/ic_launcher",
            largeIcon: const DrawableResourceAndroidBitmap(
                '@drawable/ic_notifications'),
          ),
          iOS:  const DarwinNotificationDetails()),
    );
  }
}
