
import 'package:flutter/material.dart';



class MediaGridWidget extends StatelessWidget {
  final List<MediaContent> mediaContent;
  final Function(MediaContent) onMediaTap;
  final Function(MediaContent) onToggleLike;

  const MediaGridWidget({
    super.key,
    required this.mediaContent,
    required this.onMediaTap,
    required this.onToggleLike,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: mediaContent.length,
        itemBuilder: (context, index) {
          final media = mediaContent[index];
          return MediaCardWidget(
            media: media,
            onTap: () => onMediaTap(media),
            onToggleLike: () => onToggleLike(media),
          );
        },
      ),
    );
  }
}