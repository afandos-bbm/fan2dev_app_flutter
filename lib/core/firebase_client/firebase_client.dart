import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fan2dev/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FirebaseClient {
  FirebaseClient._();

  static late FirebaseClient _instance;
  static late FirebaseApp _firebaseInstance;
  static late FirebaseMessaging _firebaseMessagingInstance;
  static late FirebaseAuth _firebaseAuthInstance;
  static late FirebaseFirestore _firebaseFirestoreInstance;

  static Future<FirebaseClient> initFirebaseClient() async {
    _instance = FirebaseClient._();
    _firebaseInstance = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _firebaseMessagingInstance = FirebaseMessaging.instance;
    _firebaseAuthInstance = FirebaseAuth.instance;
    _firebaseFirestoreInstance = FirebaseFirestore.instance;
    _firebaseFirestoreInstance.settings = const Settings(
      persistenceEnabled: true,
    );
    if (kIsWeb) {
      await _firebaseAuthInstance.setPersistence(Persistence.LOCAL);
    }

    return _instance;
  }

  FirebaseApp get firebaseInstance => _firebaseInstance;
  FirebaseMessaging get firebaseMessagingInstance => _firebaseMessagingInstance;
  FirebaseAuth get firebaseAuthInstance => _firebaseAuthInstance;
}
