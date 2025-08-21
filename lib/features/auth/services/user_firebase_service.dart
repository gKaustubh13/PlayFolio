import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:playfolio/features/auth/models/user_model.dart';

class UserFirebaseService {
  final _client = FirebaseFirestore.instance;

  Future<UserModel?> create(UserModel model) async {
    try {
      final ref = _client.collection("users").doc(model.id);
      await ref.set(model.toMap());
      return model;
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> get(String id) async {
    try {
      final ref = _client.collection("users").doc(id);
      final snapshot = await ref.get();
      final map = snapshot.data();
      if (map == null) return null;
      return UserModel.fromMap(map);
    } catch (e) {
      return null;
    }
  }
}
