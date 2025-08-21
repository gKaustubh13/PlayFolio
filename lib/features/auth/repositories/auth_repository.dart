import 'package:playfolio/features/auth/models/login_request_model.dart';
import 'package:playfolio/features/auth/models/register_request_model.dart';
import 'package:playfolio/features/auth/models/user_model.dart';
import 'package:playfolio/features/auth/services/auth_firebase_service.dart';

class AuthRepository {
  final AuthFirebaseService _authService;
  AuthRepository(this._authService);

  Stream<UserModel?> getUserStream() {
    return _authService.getUserStream();
  }

  Future<UserModel?> register(RegisterRequestModel request) {
    return _authService.register(request);
  }

  Future<UserModel?> login(LoginRequestModel request) {
    return _authService.login(request);
  }

  Future<void> signInAnonymously() {
    return _authService.signInAnonymously();
  }

  Future<void> logout() {
    return _authService.logout();
  }
}
