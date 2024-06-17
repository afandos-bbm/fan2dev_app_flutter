import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan2dev/core/firebase_client/firebase_client.dart';
import 'package:fan2dev/core/locator/locator.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  AuthService({
    this.createdAt,
    this.isAdmin,
  }) {
    final auth = locator<FirebaseClient>().firebaseAuthInstance;

    if (auth.currentUser != null) {
      final db = locator<FirebaseClient>().firebaseFirestoreInstance;

      db.collection('users').doc(auth.currentUser!.uid).get().then((user) {
        if (user.exists) {
          login(
            user.data()!.containsKey('isAdmin') &&
                user.data()!['isAdmin'] == true,
            DateTime.fromMillisecondsSinceEpoch(
              (user.data()!['createdAt'] as Timestamp).millisecondsSinceEpoch,
            ),
          );
        }
      });
    }
  }

  DateTime? createdAt;
  bool? isAdmin;

  void login(bool isAdmin, DateTime createdAt) {
    this.isAdmin = isAdmin;
    this.createdAt = createdAt;
    notifyListeners();
  }

  void logout() {
    this.isAdmin = null;
    this.createdAt = null;
    notifyListeners();
  }
}
