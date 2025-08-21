import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:playfolio/features/games/models/game_details.dart';
import 'package:playfolio/features/games/view/widgets/screenshot_viewer.dart';

class GameDetailsView extends StatelessWidget {
  final GameDetailsModel game;
  const GameDetailsView({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250.0,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              game.name,
              style: const TextStyle(shadows: [Shadow(blurRadius: 8)]),
            ),
            background: CachedNetworkImage(
              imageUrl: 'https:${game.coverUrl}',
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle(context, 'Rating'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    const SizedBox(width: 8),
                    Text(
                      '${(game.rating / 10).toStringAsFixed(1)} / 10',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildSectionTitle(context, 'Genres'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  children: game.genres
                      .map((genre) => Chip(label: Text(genre)))
                      .toList(),
                ),
                const SizedBox(height: 24),
                _buildSectionTitle(context, 'Summary'),
                const SizedBox(height: 8),
                Text(
                  game.summary,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                _buildSectionTitle(context, 'Platforms'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  children: game.platforms
                      .map((p) => Chip(label: Text(p)))
                      .toList(),
                ),
                const SizedBox(height: 24),
                _buildSectionTitle(context, 'Screenshots'),
                const SizedBox(height: 8),
                ScreenshotViewer(screenshotUrls: game.screenshotUrls),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
