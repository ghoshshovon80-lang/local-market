import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

abstract class AppConfig {
  static bool useFirebase = false;
}

class FirebaseService {
  static final FirebaseService instance = FirebaseService._internal();

  FirebaseService._internal();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  FirebaseFirestore? get firestore =>
      _isInitialized ? FirebaseFirestore.instance : null;
  FirebaseStorage? get storage =>
      _isInitialized ? FirebaseStorage.instance : null;
  FirebaseAuth? get auth => _isInitialized ? FirebaseAuth.instance : null;

  Future<bool> initializeFirebase() async {
    try {
      if (Firebase.apps.isNotEmpty) {
        _isInitialized = true;
        AppConfig.useFirebase = true;
        return true;
      }

      await Firebase.initializeApp();
      _isInitialized = true;
      AppConfig.useFirebase = true;
      if (kDebugMode) {
        print('Firebase Service successfully initialized!');
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Firebase Service initialization skipped/failed: $e');
      }
      _isInitialized = false;
      AppConfig.useFirebase = false;
      return false;
    }
  }
}
