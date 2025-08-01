

import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

class MediaHeaderWidget extends StatelessWidget {
  final MediaStats stats;
  final MediaType selectedType;
  final VoidCallback onUploadPressed;

  const MediaHeaderWidget({
    super.key,
    required this.stats,
    required this.selectedType,
    required this.onUploadPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(
            Icons.photo_library,
            color: AppTheme.moroccoGreen,
            size: 20,
          ),
          const SizedBox(width: 8),
          const Text(
            'Community Media',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryText,
            ),
          ),
          const Spacer(),
          
          // Media stats
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${stats.photoCount}📸',
                  style: const TextStyle(fontSize: 11),
                ),
                const SizedBox(width: 4),
                Text(
                  '${stats.videoCount}🎥',
                  style: const TextStyle(fontSize: 11),
                ),
                const SizedBox(width: 4),
                Text(
                  '${stats.totalEngagement}❤️',
                  style: const TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 8),
          
          // Upload button
          IconButton(
            onPressed: onUploadPressed,
            icon: const Icon(
              Icons.add_a_photo,
              color: AppTheme.moroccoGreen,
            ),
            tooltip: 'Upload ${selectedType.displayName}',
          ),
        ],
      ),
    );
  }
}