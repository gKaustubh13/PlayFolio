import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ScreenshotViewer extends StatelessWidget {
  final List<String> screenshotUrls;
  const ScreenshotViewer({super.key, required this.screenshotUrls});

  @override
  Widget build(BuildContext context) {
    if (screenshotUrls.isEmpty) {
      return const Text('No screenshots available.');
    }
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: screenshotUrls.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: 'https:${screenshotUrls[index]}',
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: Colors.grey[800]),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          );
        },
      ),
    );
  }
}
