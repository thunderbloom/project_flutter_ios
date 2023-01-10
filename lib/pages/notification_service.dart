import 'dart:io';
import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/pages/show_history_db.dart';
import 'package:get/get.dart';

/// Step 2. Create a NotificationService class
class NotificationService {
  // Singleton pattern, https://en.wikipedia.org/wiki/Singleton_pattern
  // 1.The _internal() construction is just a name often given to constructors
  // that are private to the class
  // 2.Use the factory keyword when implementing a constructor
  // that does not create a new instance of its class.
  NotificationService._internal();
  static final NotificationService _notificationService =
      NotificationService._internal();
  factory NotificationService() {
    return _notificationService;
  }
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  // Configuration for platform-specific initialization settings.

  @override
  void initState() {
    init();
  }

  Future<void> init() async {
    // Specifies the default icon for notifications.
    // icon path: PROJECT_NAME\android\app\src\main\res\drawable\icon.png
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("icon");

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  // Some configurations for platform-specific notification's details.
  static const AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails(
    'ChannelId',
    'ChannelName',
    channelDescription: "Responsible for all local notifications",
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );
  final NotificationDetails notificationDetails =
      const NotificationDetails(android: _androidNotificationDetails);

  // Now we need to call the show() method of FlutterLocalNotificationsPlugin.
  // Show() is responsible for showing the local notification.
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> showNotification(int id, String title, String body) async {
    await flutterLocalNotificationsPlugin.show(
        id, title, body, notificationDetails);
  }
//   void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
//     final String? payload = notificationResponse.payload;
//     if (notificationResponse.payload != null) {
//       debugPrint('notification payload: $payload');
//     }
//     await Navigator.push(
//       context,
//       MaterialPageRoute<void>(builder: (context) => HistoryData(payload)),
//     );
// }

//   void sensor() {
//     // Get.to(() => HomeScreen(), transition: Transition.rightToLeft);
//     Get.to(() => HistoryData());
//   }
}
