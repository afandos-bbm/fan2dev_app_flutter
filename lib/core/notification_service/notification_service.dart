import 'dart:async';

import 'package:fan2dev/core/core.dart';
import 'package:fan2dev/core/firebase_client/firebase_client.dart';
import 'package:fan2dev/utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:talker/talker.dart';

class NotificationService with ChangeNotifier {
  static late NotificationService _instance;

  late StreamController<String?> _foregroundStreamController;
  Stream<String?> get foregroundMessagesStream =>
      _foregroundStreamController.stream;

  late StreamController<RemoteMessage> _backgroundStreamController;
  Stream<RemoteMessage> get backgroundMessagesStream =>
      _backgroundStreamController.stream;

  bool get hasNotificationsEnabled =>
      locator<SharedPreferencesService>().hasNotificationsEnabled;

  static Future<NotificationService> initNotificationService() async {
    _instance = NotificationService();
    await _instance._configureNotifications();

    return _instance;
  }

  Future<void> _configureNotifications() async {
    try {
      final hasPermission =
          locator<SharedPreferencesService>().hasNotificationsEnabled;

      if (!hasPermission) {
        l(
          'User has not granted permission for notifications. Disabling...',
          name: '🔔 Notification Service',
          level: LogLevel.warning,
        );
        await disableNotifications();
      }

      _foregroundStreamController = StreamController.broadcast();
      _backgroundStreamController = StreamController.broadcast();

      FirebaseMessaging.onBackgroundMessage(_onBackgroundMessageHandler);
      FirebaseMessaging.onMessage.listen(_onMessageHandler);
      FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedAppHandler);

      final messaging = locator<FirebaseClient>().firebaseMessagingInstance;
      final token = await messaging.getToken();

      if (token == null) {
        l(
          'Token is null',
          name: '🔔 Notification Service',
          level: LogLevel.error,
        );
        throw Exception('Token is null');
      } else {
        l(
          'Token: $token',
          name: '🔔 Notification Service',
        );
      }

      locator<SharedPreferencesService>().notificationsToken = token;

      notifyListeners();
    } catch (e) {
      l(
        'Error configuring notifications: $e',
        name: '🔔 Notification Service',
        level: LogLevel.error,
      );
    }
  }

  static Future<bool> _requestPermission() async {
    final messaging = locator<FirebaseClient>().firebaseMessagingInstance;

    final notificationSettings = await messaging.getNotificationSettings();

    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      l(
        'Notifications are already authorized, skipping request.',
        name: '🔔 Notification Service',
      );

      return true;
    }

    final newNotificationsSettings = await messaging.requestPermission();
    l(
      'User push notification status: ${newNotificationsSettings.authorizationStatus}',
      name: '🔔 Notification Service',
    );

    if (newNotificationsSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> enableNotifications() async {
    final messaging = locator<FirebaseClient>().firebaseMessagingInstance;

    final hasPermission = await _requestPermission();

    if (!hasPermission) {
      l(
        'User has not granted permission for notifications, skipping enabling.',
        name: '🔔 Notification Service',
        level: LogLevel.warning,
      );
      return;
    }

    final token = await messaging.getToken();

    await messaging.setAutoInitEnabled(token != null);
    locator<SharedPreferencesService>().notificationsToken = token ?? '';
    locator<SharedPreferencesService>().hasNotificationsEnabled = token != null;

    l(
      'Notifications enabled',
      name: '🔔 Notification Service',
    );

    notifyListeners();
  }

  Future<void> disableNotifications() async {
    final messaging = locator<FirebaseClient>().firebaseMessagingInstance;

    await messaging.deleteToken();
    await messaging.setAutoInitEnabled(false);

    locator<SharedPreferencesService>().notificationsToken = '';
    locator<SharedPreferencesService>().hasNotificationsEnabled = false;

    l(
      'Notifications disabled',
      name: '🔔 Notification Service',
    );

    notifyListeners();
  }

  Future<void> toggleNotifications() async {
    if (hasNotificationsEnabled) {
      await disableNotifications();
    } else {
      await enableNotifications();
    }
  }

  static Future<void> _onBackgroundMessageHandler(RemoteMessage message) async {
    l(
      'Message received on background ID:${message.messageId ?? ' ❌ No ID'}',
      name: '🔔 Notification Service',
    );
    l(
      'Message payload: ${message.notification}',
      name: '🔔 Notification Service',
    );
  }

  Future<void> _onMessageHandler(RemoteMessage message) async {
    l(
      'Message received on foreground ID:${message.messageId ?? ' ❌ No ID'}',
      name: '🔔 Notification Service',
    );
    l(
      'Message payload: ${message.data}',
      name: '🔔 Notification Service',
    );
    _foregroundStreamController.add(message.notification?.title);
  }

  Future<void> _onMessageOpenedAppHandler(RemoteMessage message) async {
    l(
      'Message received on background clicked ID:${message.messageId ?? ' ❌ No ID'}',
      name: '🔔 Notification Service',
    );
    l(
      'Message payload: ${message.data}',
      name: '🔔 Notification Service',
    );
    _backgroundStreamController.add(message);
  }
}
