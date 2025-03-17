import 'package:emerald_beauty/api_classes/check_connectivity.dart';
import 'package:emerald_beauty/api_classes/parse_api.dart';
import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/model_class/notifications/notifications.dart';
import 'package:flutter/material.dart';

class Notifcations {
  ParseApi api = ParseApi();
  CheckConnectivity internet = CheckConnectivity();

  Future<int> notificationsCounts() async {
    int result = 0;
    try {
      final bool isConnected = await internet.isConnected();

      if (isConnected) {
        var response =
            await api.makeRequest(url: ApiUrls.unreadCount, method: Method.GET);

        final bool status = response["status"];

        if (status) {
          result = response["data"]["unread_count"];

          debugPrint("Count: $result");
        } else {
          debugPrint("Response: ${response["message"]}");
        }
      } else {
        debugPrint("Check internet connection");
      }
    } catch (e) {
      debugPrint("Exception: $e");
    }
    return result;
  }

  Future<NotificationResponse?> getAllNotifications() async {
    NotificationResponse? result;
    try {
      final bool isConnected = await internet.isConnected();

      if (isConnected) {
        var response = await api.makeRequest(
            url: ApiUrls.notifications, method: Method.GET);

        final bool status = response["status"];

        if (status) {
          result = NotificationResponse.fromMap(response);
        } else {
          debugPrint("Error: ${response["message"]}");
        }
      } else {
        debugPrint("Check internet connection");
      }
    } catch (e) {
      debugPrint("Exception: $e");
    }
    return result;
  }

  Future<void> markAllReadNotifications() async {
    try {
      final bool isConnected = await internet.isConnected();

      if (isConnected) {
        var response = await api.makeRequest(
            url: ApiUrls.markAllRead, method: Method.POST);

        final bool status = response["status"];

        if (status) {
          debugPrint("Success: ${response["message"]}");
        } else {
          debugPrint("Error: ${response["message"]}");
        }
      } else {
        debugPrint("Check internet connection");
      }
    } catch (e) {
      debugPrint("Exception: $e");
    }
  }
}
