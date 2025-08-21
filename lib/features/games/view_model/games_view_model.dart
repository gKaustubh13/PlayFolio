import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playfolio/core/providers.dart';
import 'package:playfolio/features/games/models/game_model.dart';
import 'package:playfolio/features/games/repositories/games_repository.dart';

final gamesViewModelProvider =
    StateNotifierProvider.autoDispose<GamesViewModel, GamesState>(
      (ref) => GamesViewModel(ref.watch(gamesRepositoryProvider)),
    );

class GamesState {
  final List<GameModel> games;
  final bool isLoading;
  final bool isFetchingMore;
  final bool hasNext;
  final String searchQuery;

  GamesState({
    this.games = const [],
    this.isLoading = false,
    this.isFetchingMore = false,
    this.hasNext = true,
    this.searchQuery = '',
  });

  GamesState copyWith({
    List<GameModel>? games,
    bool? isLoading,
    bool? isFetchingMore,
    bool? hasNext,
    String? searchQuery,
  }) {
    return GamesState(
      games: games ?? this.games,
      isLoading: isLoading ?? this.isLoading,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
      hasNext: hasNext ?? this.hasNext,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class GamesViewModel extends StateNotifier<GamesState> {
  final GamesRepository _repository;
  Timer? _debounce;

  GamesViewModel(this._repository) : super(GamesState()) {
    fetchInitialGames();
  }

  Future<void> fetchInitialGames() async {
    state = state.copyWith(isLoading: true, games: [], hasNext: true);
    final games = await _repository.fetchGames(searchQuery: state.searchQuery);
    state = state.copyWith(games: games, isLoading: false);
  }

  Future<void> fetchMoreGames() async {
    if (state.isFetchingMore || !state.hasNext) return;

    state = state.copyWith(isFetchingMore: true);
    final newGames = await _repository.fetchGames(
      offset: state.games.length,
      searchQuery: state.searchQuery,
    );

    if (newGames.isEmpty) {
      state = state.copyWith(hasNext: false, isFetchingMore: false);
    } else {
      state = state.copyWith(
        games: [...state.games, ...newGames],
        isFetchingMore: false,
      );
    }
  }

  void search(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      state = state.copyWith(searchQuery: query);
      fetchInitialGames();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
