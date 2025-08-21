import 'package:playfolio/features/games/models/game_details.dart';
import 'package:playfolio/features/games/models/game_model.dart';
import 'package:playfolio/features/games/services/games_api_service.dart';

class GamesRepository {
  final GamesApiService _apiService;

  GamesRepository(this._apiService);

  Future<List<GameModel>> fetchGames({
    int limit = 10,
    int offset = 0,
    String searchQuery = '',
  }) {
    return _apiService.fetchGames(
      limit: limit,
      offset: offset,
      searchQuery: searchQuery,
    );
  }

  Future<GameDetailsModel> fetchGameDetails(int gameId) {
    return _apiService.fetchGameDetails(gameId);
  }
}
