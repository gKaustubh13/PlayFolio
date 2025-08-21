import 'package:firebase_auth/firebase_auth.dart';
import 'package:playfolio/features/auth/models/login_request_model.dart';
import 'package:playfolio/features/auth/models/register_request_model.dart';
import 'package:playfolio/features/auth/models/user_model.dart';
import 'package:playfolio/features/auth/services/user_firebase_service.dart';

class AuthFirebaseService {
  final _authClient = FirebaseAuth.instance;
  final _userService = UserFirebaseService();

  Stream<UserModel?> getUserStream() {
    return _authClient.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) return null;

      if (firebaseUser.isAnonymous) {
        return UserModel.anonymous(firebaseUser.uid);
      }

      return await _userService.get(firebaseUser.uid);
    });
  }

  Future<UserModel?> register(RegisterRequestModel request) async {
    final userCredential = await _authClient.createUserWithEmailAndPassword(
      email: request.email,
      password: request.password,
    );
    final id = userCredential.user?.uid;
    if (id == null) return null;

    final model = UserModel.fromRegisterRequestModel(id, request);
    return await _userService.create(model);
  }

  Future<UserModel?> login(LoginRequestModel request) async {
    final userCredential = await _authClient.signInWithEmailAndPassword(
      email: request.email,
      password: request.password,
    );
    final id = userCredential.user?.uid;
    if (id == null) return null;
    return await _userService.get(id);
  }

  Future<void> signInAnonymously() async {
    await _authClient.signInAnonymously();
  }

  Future<void> logout() async {
    await _authClient.signOut();
  }
}
