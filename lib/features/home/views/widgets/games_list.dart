import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playfolio/features/games/view_model/games_view_model.dart';
import 'package:playfolio/features/home/views/widgets/game_card.dart';

class GamesList extends ConsumerStatefulWidget {
  const GamesList({super.key});

  @override
  ConsumerState<GamesList> createState() => _GamesListState();
}

class _GamesListState extends ConsumerState<GamesList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      ref.read(gamesViewModelProvider.notifier).fetchMoreGames();
    }
  }

  @override
  Widget build(BuildContext context) {
    final gamesState = ref.watch(gamesViewModelProvider);

    if (gamesState.isLoading && gamesState.games.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (gamesState.games.isEmpty) {
      return const Center(
        child: Text('No games found. Try a different search!'),
      );
    }

    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: gamesState.games.length + (gamesState.isFetchingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == gamesState.games.length) {
          return const Center(child: CircularProgressIndicator());
        }
        final game = gamesState.games[index];
        return GameCard(game: game);
      },
    );
  }
}
