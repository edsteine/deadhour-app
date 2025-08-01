
import 'package:flutter/material.dart';




class MediaDetailsDialog {
  static void show(
    BuildContext context,
    MediaContent media,
    VoidCallback onToggleLike,
  ) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(16),
        child: MediaDetailsContent(
          media: media,
          onToggleLike: onToggleLike,
        ),
      ),
    );
  }
}

