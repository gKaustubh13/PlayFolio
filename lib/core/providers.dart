import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playfolio/features/auth/models/user_model.dart';
import 'package:playfolio/features/auth/repositories/auth_repository.dart';
import 'package:playfolio/features/auth/services/auth_firebase_service.dart';
import 'package:playfolio/features/games/repositories/games_repository.dart';
import 'package:playfolio/features/games/services/games_api_service.dart';

final authFirebaseServiceProvider = Provider<AuthFirebaseService>(
  (ref) => AuthFirebaseService(),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(ref.watch(authFirebaseServiceProvider)),
);

final authStateChangesProvider = StreamProvider.autoDispose<UserModel?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.getUserStream();
});

final dioProvider = Provider<Dio>((ref) => Dio());

final gamesApiServiceProvider = Provider<GamesApiService>(
  (ref) => GamesApiService(ref.watch(dioProvider)),
);

final gamesRepositoryProvider = Provider<GamesRepository>(
  (ref) => GamesRepository(ref.watch(gamesApiServiceProvider)),
);
