import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playfolio/features/games/view/widgets/game_details_view.dart';
import 'package:playfolio/features/games/view_model/game_details_view_model.dart';

class GameDetailsScreen extends ConsumerWidget {
  final int gameId;
  const GameDetailsScreen({super.key, required this.gameId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameDetailsAsync = ref.watch(gameDetailsViewModelProvider(gameId));

    return Scaffold(
      body: gameDetailsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (game) => GameDetailsView(game: game),
      ),
    );
  }
}
