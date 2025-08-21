import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playfolio/core/providers.dart';
import 'package:playfolio/features/auth/repositories/auth_repository.dart';

final homeViewModelProvider = Provider.autoDispose((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return HomeViewModel(authRepository);
});

class HomeViewModel {
  final AuthRepository _authRepository;

  HomeViewModel(this._authRepository);

  Future<void> signOut() {
    return _authRepository.logout();
  }
}
