class GameDetailsModel {
  final int id;
  final String name;
  final String summary;
  final String coverUrl;
  final List<String> genres;
  final List<String> platforms;
  final List<String> screenshotUrls;
  final double rating;

  GameDetailsModel({
    required this.id,
    required this.name,
    required this.summary,
    required this.coverUrl,
    required this.genres,
    required this.platforms,
    required this.screenshotUrls,
    required this.rating,
  });

  factory GameDetailsModel.fromJson(Map<String, dynamic> json) {
    List<String> extractNames(List<dynamic>? items) =>
        items?.map((item) => item['name'] as String).toList() ?? [];
    List<String> extractImageUrls(List<dynamic>? items) =>
        items
            ?.map(
              (item) => (item['url'] as String).replaceFirst(
                't_thumb',
                't_screenshot_big',
              ),
            )
            .toList() ??
        [];

    return GameDetailsModel(
      id: json['id'],
      name: json['name'] ?? 'Unknown Name',
      summary: json['summary'] ?? 'No summary available.',
      coverUrl: (json['cover']?['url'] as String? ?? '').replaceFirst(
        't_thumb',
        't_cover_big',
      ),
      genres: extractNames(json['genres']),
      platforms: extractNames(json['platforms']),
      screenshotUrls: extractImageUrls(json['screenshots']),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
