import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playfolio/features/auth/data/repositories/auth_repository.dart';
import 'package:playfolio/features/auth/presentation/controllers/auth_controller.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(firebaseAuth: ref.watch(firebaseAuthProvider)),
);

final authStateChangesProvider = StreamProvider<User?>(
  (ref) => ref.watch(authRepositoryProvider).authStateChanges,
);

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<void>>(
      (ref) => AuthController(ref.watch(authRepositoryProvider)),
    );

final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authStateChangesProvider).value;
});

final isSignedInProvider = Provider<bool>((ref) {
  return ref.watch(authStateChangesProvider).value != null;
});

final isAnonymousProvider = Provider<bool>((ref) {
  final user = ref.watch(authStateChangesProvider).value;
  return user?.isAnonymous ?? false;
});
