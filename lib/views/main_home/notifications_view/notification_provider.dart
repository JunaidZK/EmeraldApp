import 'package:emerald_beauty/api_classes/notifications/notifications.dart';
import 'package:emerald_beauty/model_class/notifications/notifications.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  Notifcations notifcationApi = Notifcations();
  NotificationResponse? notifications;

  Future<void> getNotifications() async {
    notifications = await notifcationApi.getAllNotifications();
    notifyListeners();
  }
}
