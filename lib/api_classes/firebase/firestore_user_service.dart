import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreUserservice {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserToFirestore({
    required String userId,
    required String name,
    required String profilePic,
  }) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'name': name,
        'profilePic': profilePic,
        'lastSeen': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception("Error saving user: $e");
    }
  }
}
