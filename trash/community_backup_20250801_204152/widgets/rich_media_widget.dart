import 'package:flutter/material.dart';
import '../services/rich_media_service.dart';
import '../../../utils/theme.dart';
import 'media/media_header_widget.dart';
import 'media/media_type_filter_widget.dart';
import 'media/media_grid_widget.dart';
import 'media/empty_media_state_widget.dart';
import 'media/media_details_dialog.dart';

/// Rich media widget for community content sharing
/// Implements Discord-style media sharing as identified in TAB_ANALYSIS_REPORT.md
class RichMediaWidget extends StatefulWidget {
  final String roomId;
  final String userId;

  const RichMediaWidget({
    super.key,
    required this.roomId,
    required this.userId,
  });

  @override
  State<RichMediaWidget> createState() => _RichMediaWidgetState();
}

class _RichMediaWidgetState extends State<RichMediaWidget> {
  final RichMediaService _mediaService = RichMediaService();
  List<MediaContent> _mediaContent = [];
  MediaType _selectedType = MediaType.photo;

  @override
  void initState() {
    super.initState();
    _mediaService.initializeMediaService();
    _loadMediaContent();
  }

  void _loadMediaContent() {
    setState(() {
      _mediaContent = _mediaService.getRoomMedia(widget.roomId);
    });
  }

  List<MediaContent> get _filteredMedia {
    return _mediaContent.where((media) => media.type == _selectedType).toList();
  }

  Future<void> _uploadMedia() async {
    // Simulate media upload
    final result = await _mediaService.uploadMedia(
      roomId: widget.roomId,
      userId: widget.userId,
      userName: 'Current User',
      type: _selectedType,
      content: _selectedType == MediaType.photo 
          ? 'https://picsum.photos/400/300?random=${DateTime.now().millisecondsSinceEpoch}'
          : 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      caption: _getSampleCaption(),
    );

    if (result.success && mounted) {
      _loadMediaContent();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${_selectedType.displayName} uploaded successfully!'),
          backgroundColor: AppTheme.moroccoGreen,
        ),
      );
    }
  }

  String _getSampleCaption() {
    final captions = {
      MediaType.photo: [
        '📸 Great experience during dead hours!',
        '✨ Perfect lighting for photos',
        '🎯 Found this amazing spot',
        '💫 Beautiful atmosphere here',
      ],
      MediaType.video: [
        '🎥 Live action from this amazing place!',
        '📱 Quick tour of the venue',
        '🎬 Behind the scenes content',
        '⚡ Energy is incredible here!',
      ],
    };
    
    final typeCaptions = captions[_selectedType] ?? captions[MediaType.photo]!;
    return typeCaptions[DateTime.now().millisecond % typeCaptions.length];
  }

  Future<void> _toggleLike(MediaContent media) async {
    final newLikes = await _mediaService.toggleLike(media.id, widget.userId);
    setState(() {
      final index = _mediaContent.indexWhere((m) => m.id == media.id);
      if (index != -1) {
        _mediaContent[index] = media.copyWith(
          likes: newLikes,
          isLikedByUser: !media.isLikedByUser,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final stats = _mediaService.getRoomMediaStats(widget.roomId);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Media header with stats
        MediaHeaderWidget(
          stats: stats,
          selectedType: _selectedType,
          onUploadPressed: _uploadMedia,
        ),
        
        // Media type filter
        MediaTypeFilterWidget(
          selectedType: _selectedType,
          onTypeChanged: (type) {
            setState(() {
              _selectedType = type;
            });
          },
        ),
        
        // Media grid
        if (_filteredMedia.isNotEmpty)
          MediaGridWidget(
            mediaContent: _filteredMedia,
            onMediaTap: (media) => MediaDetailsDialog.show(
              context,
              media,
              () => _toggleLike(media),
            ),
            onToggleLike: _toggleLike,
          )
        else
          EmptyMediaStateWidget(
            selectedType: _selectedType,
            onUploadPressed: _uploadMedia,
          ),
      ],
    );
  }
}