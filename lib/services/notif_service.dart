import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static const key =
      'AAAAS7YKmU4:APA91bEOW9oLuqFcaMPlElfBxx6VniXOG7VoIjtLY6xXkX-Zc6pYd4rNzFwaxen-0WKr-i9dgeEjSju13yFxMDxg8sX3cFk1kv3wQ6ceeNfmZdLon-StvqrwYdu0BNBV5qroS02yIFxX';

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void _initLocalNotification() {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initializationSettings =
        InitializationSettings(android: androidSettings);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void firebaseNotification(context) {
    _initLocalNotification();

    FirebaseMessaging.onMessageOpenedApp
        .listen((RemoteMessage message) async {});

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await _showLocalNotification(message);
    });
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    final styleInformation = BigTextStyleInformation(
      message.notification!.body.toString(),
      htmlFormatBigText: true,
      contentTitle: message.notification!.title,
      htmlFormatTitle: true,
    );
    final androidDetails = AndroidNotificationDetails(
        'com.hgt.compra', 'COMPRA SA HGT',
        styleInformation: styleInformation, importance: Importance.high);
    final notificationDetails = NotificationDetails(
      android: androidDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification!.title,
      message.notification!.body,
      notificationDetails,
      payload: message.data['body'],
    );
  }

  Future<void> requestPermission() async {
    final message = FirebaseMessaging.instance;
    final settings = await message.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    settings.authorizationStatus == AuthorizationStatus.authorized
        ? debugPrint('User Granted Permission')
        : settings.authorizationStatus == AuthorizationStatus.provisional
            ? debugPrint('User Granted Provisional Status')
            : debugPrint('User Denied Permission');
  }
}
