import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:playfolio/features/games/models/game_details.dart';
import 'package:playfolio/features/games/models/game_model.dart';

class GamesApiService {
  final Dio _dio;
  final String _baseUrl = 'https://api.igdb.com/v4';
  final String _clientId = dotenv.env['IGDB_CLIENT_ID']!;
  final String _authToken = dotenv.env['IGDB_AUTH_TOKEN']!;

  GamesApiService(this._dio) {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.headers = {
      'Client-ID': _clientId,
      'Authorization': 'Bearer $_authToken',
    };
  }

  Future<List<GameModel>> fetchGames({
    int limit = 10,
    int offset = 0,
    String searchQuery = '',
  }) async {
    try {
      String body =
          'fields name, cover.url, rating; limit $limit; offset $offset;';
      if (searchQuery.isNotEmpty) {
        body += ' search "$searchQuery";';
      }

      final response = await _dio.post('/games', data: body);
      final List results = response.data as List;
      return results.map((gameJson) => GameModel.fromJson(gameJson)).toList();
    } on DioException catch (e) {
      throw Exception("Failed to load games: ${e.message}");
    }
  }

  Future<GameDetailsModel> fetchGameDetails(int gameId) async {
    try {
      const String fields =
          'fields name, summary, cover.url, genres.name, platforms.name, screenshots.url, rating;';
      final String body = '$fields where id = $gameId;';

      final response = await _dio.post('/games', data: body);

      if (response.data != null && (response.data as List).isNotEmpty) {
        return GameDetailsModel.fromJson((response.data as List).first);
      } else {
        throw Exception("Game not found");
      }
    } on DioException catch (e) {
      throw Exception("Failed to load game details: ${e.message}");
    }
  }
}
