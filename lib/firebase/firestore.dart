import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirestoreUser {
  final FirebaseFirestore _firestore = FirebaseFirestore.instanceFor(
      app: Firebase.app(), databaseId: "emerald-beauty");

  Future<void> saveUsers({
    required RequestFrom requestFrom,
    required int userId,
    required String input,
    required String firstName,
    required String lastName,
    String? profilePic,
  }) async {
    try {
      // Get FCM token
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      if (fcmToken == null) {
        debugPrint("FCM token is null");
      }

      // Prepare user data
      Map<String, dynamic> userData = {
        requestFrom == RequestFrom.email ? "email" : "phone": input,
        "first_name": firstName,
        "last_name": lastName,
        "profile_pic": profilePic,
        "fcm_token": fcmToken,
        "updatedAt": FieldValue.serverTimestamp(), // Optional but recommended
      };

      // Save to Firestore
      await _firestore
          .collection("users")
          .doc(userId.toString())
          .set(userData, SetOptions(merge: true))
          .then((val) => debugPrint("User Added Successfully"))
          .onError((e, stackTrace) => debugPrint("Error: $e"));
    } catch (e) {
      debugPrint("saveUsers Error: $e");
    }
  }

  Future<Map<String, dynamic>?> fetchEmployee({required int employeeId}) async {
    Map<String, dynamic>? userDetails;
    try {
      var userSnapShot =
          await _firestore.collection("users").doc(employeeId.toString()).get();

      if (userSnapShot.exists) {
        return userSnapShot.data(); // Return user data
      } else {
        debugPrint("User not found in Firestore");
      }
    } catch (e) {
      debugPrint("Exception: $e");
    }
    return userDetails;
  }

  //Creating a chatID between 2 users
  Future<String> createOrGetChatRoomId({
    required String senderId,
    required String receiverId,
  }) async {
    try {
      var chatsCollection = _firestore.collection("chats");

      // Check if chat already exists between sender and receiver
      var chatQuery = await chatsCollection
          .where('participants', arrayContains: senderId)
          .get();

      String chatRoomId = '';

      for (var doc in chatQuery.docs) {
        var participants = doc.data()['participants'] as List<dynamic>;
        if (participants.contains(receiverId)) {
          chatRoomId = doc.id;
          break;
        }
      }

      if (chatRoomId.isEmpty) {
        // Create a new chat room
        var chatRoomDoc = await chatsCollection.add({
          'participants': [senderId, receiverId],
          'lastMessage': '',
          'lastMessageTime': FieldValue.serverTimestamp(),
        });
        chatRoomId = chatRoomDoc.id;
      }

      return chatRoomId;
    } catch (e) {
      debugPrint("Error in createOrGetChatRoomId: $e");
      rethrow;
    }
  }

  Future<void> sendMessage({
    required String chatRoomId,
    required String senderId,
    required String receiverId,
    required String message,
  }) async {
    try {
      var messageData = {
        'senderId': senderId,
        'receiverId': receiverId,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
        'type': 'text',
      };

      await _firestore
          .collection('chats')
          .doc(chatRoomId)
          .collection('messages')
          .add(messageData);

      // Optionally update the last message info for easy querying
      await _firestore.collection('chats').doc(chatRoomId).update({
        'lastMessage': message,
        'lastMessageTime': FieldValue.serverTimestamp(),
      });

      debugPrint("Message sent!");
    } catch (e) {
      debugPrint("Error sending message: $e");
    }
  }

  Stream<QuerySnapshot> getMessagesStream(String chatRoomId) {
    return _firestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Stream<List<Map<String, dynamic>>> userChatsStream(String currentUserId) {
    return _firestore
        .collection('chats')
        .where('participants', arrayContains: currentUserId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .asyncMap((querySnapshot) async {
      List<Map<String, dynamic>> chatList = [];

      for (var chatDoc in querySnapshot.docs) {
        var chatData = chatDoc.data();

        List participants = chatData['participants'];
        String otherUserId =
            participants.firstWhere((id) => id != currentUserId);

        var userSnapshot =
            await _firestore.collection('users').doc(otherUserId).get();

        var userData = userSnapshot.data();

        chatList.add({
          'chatRoomId': chatDoc.id,
          'otherUserId': otherUserId,
          'firstName': userData?['first_name'],
          'lastName': userData?['last_name'],
          'profilePic': userData?['profile_pic'],
          'lastMessage': chatData['lastMessage'],
          'lastMessageTime': chatData['lastMessageTime'],
        });
      }

      return chatList;
    });
  }
}
