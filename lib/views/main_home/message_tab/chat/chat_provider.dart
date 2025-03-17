import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/firebase/firestore.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  Map<String, dynamic>? userDetails;
  TextEditingController message = TextEditingController();
  FirestoreUser chatUser = FirestoreUser();

  String? chatRoomId;
  Stream<QuerySnapshot>? messageStream;

  // Assuming you have senderId stored somewhere like SharedPreferences or local storage
  late String senderId;

  ChatProvider() {
    // Example senderId, replace with actual user ID
    senderId = ApiUrls.userId.toString();
  }

  Future<void> initChat({required int receiverId}) async {
    // 1. Fetch receiver user details
    userDetails = await chatUser.fetchEmployee(employeeId: receiverId);

    // 2. Create or get chat room ID
    chatRoomId = await chatUser.createOrGetChatRoomId(
      senderId: senderId,
      receiverId: receiverId.toString(),
    );

    // 3. Listen to messages
    messageStream = chatUser.getMessagesStream(chatRoomId!);

    notifyListeners();
  }

  Future<void> sendMessage({required int employeeId}) async {
    if (message.text.trim().isEmpty || chatRoomId == null) return;

    await chatUser.sendMessage(
      chatRoomId: chatRoomId!,
      senderId: senderId,
      receiverId: employeeId.toString(),
      message: message.text.trim(),
    );

    message.clear();
    notifyListeners();
  }

  String formatTime(Timestamp? timestamp) {
    if (timestamp == null) {
      return "";
    }

    DateTime dateTime = timestamp.toDate();

    String formattedTime =
        "${_formatHour(dateTime.hour)}:${dateTime.minute.toString().padLeft(2, '0')} ${_getAmPm(dateTime.hour)}";

    return formattedTime;
  }

  String _formatHour(int hour) {
    int formattedHour = hour % 12;
    return (formattedHour == 0 ? 12 : formattedHour).toString();
  }

  String _getAmPm(int hour) {
    return hour >= 12 ? "PM" : "AM";
  }
}
