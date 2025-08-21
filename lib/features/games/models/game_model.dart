class GameModel {
  final int id;
  final String name;
  final String coverUrl;
  final double rating;

  GameModel({
    required this.id,
    required this.name,
    required this.coverUrl,
    required this.rating,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    final cover = json['cover'] as Map<String, dynamic>?;
    final imageUrl = cover?['url'] as String? ?? '';

    return GameModel(
      id: json['id'],
      name: json['name'] ?? 'Unknown Name',
      coverUrl: imageUrl.replaceFirst('t_thumb', 't_cover_big'),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
