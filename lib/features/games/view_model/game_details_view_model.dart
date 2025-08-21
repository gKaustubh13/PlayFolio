import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playfolio/core/providers.dart';
import 'package:playfolio/features/games/models/game_details.dart';

final gameDetailsViewModelProvider = FutureProvider.family
    .autoDispose<GameDetailsModel, int>((ref, gameId) {
      final repository = ref.watch(gamesRepositoryProvider);
      return repository.fetchGameDetails(gameId);
    });
