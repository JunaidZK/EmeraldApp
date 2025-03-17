import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emerald_beauty/firebase/firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class MessageProvider extends ChangeNotifier {
  final searchController = TextEditingController();
  FirestoreUser chatUser = FirestoreUser();

  List<Map<String, dynamic>> chats = [];

  bool isLoading = false;

  StreamSubscription? _chatStreamSubscription;

  void listenToChats(String currentUserId) {
    isLoading = true;
    notifyListeners();

    _chatStreamSubscription =
        chatUser.userChatsStream(currentUserId).listen((chatList) {
      chats = chatList;
      isLoading = false;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _chatStreamSubscription?.cancel();
    searchController.dispose();
    super.dispose();
  }

  String formatTimestamp(dynamic timestamp) {
    if (timestamp == null) return '';

    DateTime dateTime;

    if (timestamp is Timestamp) {
      dateTime = timestamp.toDate();
    } else if (timestamp is DateTime) {
      dateTime = timestamp;
    } else {
      try {
        dateTime = DateTime.parse(timestamp.toString());
      } catch (e) {
        return '';
      }
    }

    final now = DateTime.now();
    final isToday = now.day == dateTime.day &&
        now.month == dateTime.month &&
        now.year == dateTime.year;

    return isToday
        ? DateFormat('hh:mm a').format(dateTime)
        : DateFormat('dd MMM, hh:mm a').format(dateTime);
  }
}
