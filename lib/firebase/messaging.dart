import 'package:emerald_beauty/components/app_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Messaging {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isAppInForeground = true; // Track app state

  Future<void> setupForFirebase() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    debugPrint("User granted permission: ${settings.authorizationStatus}");

    String? token = await _firebaseMessaging.getToken();
    debugPrint("FCM Token: $token");

    _initializeLocalNotifications();

    // Foreground message listener
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Foreground message received!');
      if (_isAppInForeground) {
        _showToast(message); // Show toast instead of notification
      } else {
        _showNotification(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('Notification clicked! Navigating...');
      _handleMessageClick(message);
    });

    // Listen to app lifecycle changes
    _setupAppLifecycleListener();
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    const InitializationSettings initSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  // Show Local Notification (Only if app is in background)
  Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      platformChannelSpecifics,
    );
  }

  // Show Toast for Foreground Notifications
  void _showToast(RemoteMessage message) {
    showToast(
        "${message.notification?.title ?? ''}: ${message.notification?.body ?? ''}");
  }

  void _handleMessageClick(RemoteMessage message) {
    debugPrint('User clicked the notification: ${message.data}');
    // Navigate to specific screen if needed
  }

  static Future<void> firebaseBackgroundMessage(RemoteMessage message) async {
    debugPrint("Handling background message: ${message.messageId}");
  }

  // Track App Lifecycle to know if it's in foreground or background
  void _setupAppLifecycleListener() {
    WidgetsBinding.instance.addObserver(
      LifecycleEventHandler(
        onResume: () => _isAppInForeground = true,
        onPause: () => _isAppInForeground = false,
      ),
    );
  }
}

// Helper class to listen to lifecycle changes
class LifecycleEventHandler extends WidgetsBindingObserver {
  final VoidCallback onResume;
  final VoidCallback onPause;

  LifecycleEventHandler({required this.onResume, required this.onPause});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      onResume();
    } else if (state == AppLifecycleState.paused) {
      onPause();
    }
  }
}
