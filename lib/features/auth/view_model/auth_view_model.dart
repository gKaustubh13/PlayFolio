import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playfolio/core/providers.dart';
import 'package:playfolio/features/auth/models/login_request_model.dart';
import 'package:playfolio/features/auth/models/register_request_model.dart';
import 'package:playfolio/features/auth/repositories/auth_repository.dart';

final authViewModelProvider =
    StateNotifierProvider.autoDispose<AuthViewModel, AsyncValue<void>>(
      (ref) => AuthViewModel(ref.watch(authRepositoryProvider)),
    );

class AuthViewModel extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _authRepository;
  AuthViewModel(this._authRepository) : super(const AsyncData(null));

  Future<void> login(LoginRequestModel request) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _authRepository.login(request));
  }

  Future<void> register(RegisterRequestModel request) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _authRepository.register(request));
  }

  Future<void> signInAnonymously() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _authRepository.signInAnonymously());
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _authRepository.logout());
  }
}
