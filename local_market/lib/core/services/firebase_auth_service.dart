import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/user_model.dart';
import 'firebase_service.dart';

class FirebaseAuthService {
  final FirebaseAuth? _auth;
  final FirebaseFirestore? _firestore;

  FirebaseAuthService({FirebaseAuth? auth, FirebaseFirestore? firestore})
    : _auth = auth ?? FirebaseService.instance.auth,
      _firestore = firestore ?? FirebaseService.instance.firestore;

  User? get currentUser => _auth?.currentUser;

  Future<UserModel?> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required UserRole role,
    String? phone,
  }) async {
    if (_auth == null || _firestore == null) return null;

    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) return null;

      final userModel = UserModel(
        uid: user.uid,
        name: name,
        email: email,
        phone: phone,
        role: role,
        createdAt: DateTime.now(),
      );

      await _firestore.collection('users').doc(user.uid).set(userModel.toMap());
      return userModel;
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (_auth == null || _firestore == null) return null;

    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) return null;

      return await getUserProfile(user.uid);
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> getUserProfile(String uid) async {
    if (_firestore == null) return null;

    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (!doc.exists || doc.data() == null) return null;
      return UserModel.fromMap(doc.data()!);
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth?.signOut();
  }
}
