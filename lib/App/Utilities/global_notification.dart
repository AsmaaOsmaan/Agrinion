import 'dart:async';
import 'dart:convert';

import 'package:agriunion/App/Utilities/cache_helper.dart';
import 'package:agriunion/App/Utilities/utils.dart';
import 'package:agriunion/Features/Notification/Data/Mapper/notification_data_mapper.dart';
import 'package:agriunion/Features/Notification/Domain/Entites/notification_data_model.dart';
import 'package:agriunion/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../Features/Notification/Presentation/ViewLogic/notification_factory.dart';
import '../constants/keys.dart';

class GlobalNotification {
  static final _notifications = FlutterLocalNotificationsPlugin();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static GlobalNotification instance = GlobalNotification._();

  GlobalNotification._();

  setUpNotification(BuildContext context) async {
    var android = const AndroidInitializationSettings("@mipmap/launcher_icon");
    var ios = const DarwinInitializationSettings();
    var initSettings = InitializationSettings(android: android, iOS: ios);

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) =>
          _handleMessage(details.payload!),
    );
    FirebaseMessaging.onMessage
        .listen((RemoteMessage message) => _showNotification(message));
    FirebaseMessaging.onMessageOpenedApp
        .listen((event) => _handleMessages(event));
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    getFcmToken();
  }

  Future<void> _handleMessages(RemoteMessage event) async {
    _handleMessage(event.data['Data']);
    _showNotification(event);
  }

  void _handleMessage(String payload) {
    var eventData = jsonDecode(payload);
    var data = Utils.convertToJson(eventData);
    NotificationDataModel model = NotificationDataMapper.fromJson(data);
    NotificationFactory factory = NotificationFactory();
    var notification = factory.initializationObject(model.notifiableType!);
    notification.navigateToNotificationDetails(navKey.currentContext, model);
  }

  Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        '${DateTime.now()}',
        "Agriunion",
        channelDescription: "channel description",
        priority: Priority.high,
        importance: Importance.max,
        playSound: true,
        shortcutId: DateTime.now().toIso8601String(),
      ),
      iOS: const DarwinNotificationDetails(),
    );
  }

  Future _showNotification(RemoteMessage event) async {
    _notifications.show(
      event.hashCode,
      event.notification!.title,
      event.notification!.body,
      await _notificationDetails(),
      payload: event.data["Data"],
    );
  }

  Future<String?> getFcmToken() async {
    String? token = await _firebaseMessaging.getToken();
    CachHelper.saveData(key: kfcmToken, value: token);
    return token;
  }
}

Future<void> firebaseMessahangingBackgroundHandler(
    RemoteMessage message) async {
  GlobalNotification.instance._handleMessages(message);
}
