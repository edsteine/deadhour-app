




import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

/// Voice channel widget for community rooms
/// Implements Discord-style voice channels as identified in TAB_ANALYSIS_REPORT.md
class VoiceChannelWidget extends StatefulWidget {
  final String roomId;
  final String userId;

  const VoiceChannelWidget({
    super.key,
    required this.roomId,
    required this.userId,
  });

  @override
  State<VoiceChannelWidget> createState() => _VoiceChannelWidgetState();
}

class _VoiceChannelWidgetState extends State<VoiceChannelWidget> {
  final VoiceChannelService _voiceService = VoiceChannelService();
  List<VoiceChannel> _voiceChannels = [];
  String? _activeChannelId;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _voiceService.initializeVoiceService();
    _loadVoiceChannels();
  }

  void _loadVoiceChannels() {
    setState(() {
      _voiceChannels = _voiceService.getRoomVoiceChannels(widget.roomId);
    });
  }

  Future<void> _joinVoiceChannel(VoiceChannel channel) async {
    final result = await _voiceService.joinVoiceChannel(channel.id, widget.userId);
    
    if (result.success) {
      setState(() {
        _activeChannelId = channel.id;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Joined ${channel.name}'),
            backgroundColor: AppTheme.moroccoGreen,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _leaveVoiceChannel() async {
    if (_activeChannelId != null) {
      await _voiceService.leaveVoiceChannel(_activeChannelId!, widget.userId);
      setState(() {
        _activeChannelId = null;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Left voice channel'),
            backgroundColor: AppTheme.secondaryText,
            duration: Duration(seconds: 1),
          ),
        );
      }
    }
  }

  Future<void> _toggleMute() async {
    if (_activeChannelId != null) {
      final isMuted = await _voiceService.toggleMute(_activeChannelId!, widget.userId);
      setState(() {
        _isMuted = isMuted;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_voiceChannels.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Voice channels header
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(
                Icons.volume_up,
                color: AppTheme.moroccoGreen,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Voice Channels',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryText,
                ),
              ),
              const Spacer(),
              if (_activeChannelId != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Connected',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppTheme.moroccoGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ),

        // Voice channel list
        ..._voiceChannels.map((channel) => _buildVoiceChannelCard(channel)),

        // Active voice controls
        if (_activeChannelId != null) _buildVoiceControls(),
      ],
    );
  }

  Widget _buildVoiceChannelCard(VoiceChannel channel) {
    final isActive = _activeChannelId == channel.id;
    final participants = _voiceService.getChannelParticipants(channel.id);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? AppTheme.moroccoGreen.withValues(alpha: 0.1) : Colors.white,
        border: Border.all(
          color: isActive ? AppTheme.moroccoGreen : Colors.grey.shade300,
          width: isActive ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => isActive ? _leaveVoiceChannel() : _joinVoiceChannel(channel),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  // Channel type icon
                  Text(
                    channel.type.icon,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 8),
                  
                  // Channel info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          channel.name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isActive ? AppTheme.moroccoGreen : AppTheme.primaryText,
                          ),
                        ),
                        Text(
                          channel.type.displayName,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Participant count and join/leave button
                  Row(
                    children: [
                      const Icon(Icons.people, size: 16, color: AppTheme.secondaryText),
                      const SizedBox(width: 4),
                      Text(
                        '${channel.activeParticipants}/${channel.maxParticipants}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.secondaryText,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        isActive ? Icons.call_end : Icons.call,
                        size: 16,
                        color: isActive ? Colors.red : AppTheme.moroccoGreen,
                      ),
                    ],
                  ),
                ],
              ),
              
              // Show participants if active
              if (isActive && participants.isNotEmpty) ...[
                const SizedBox(height: 8),
                _buildParticipantsList(participants),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParticipantsList(List<VoiceParticipant> participants) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Participants:',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppTheme.secondaryText,
            ),
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: participants.map((participant) => _buildParticipantChip(participant)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantChip(VoiceParticipant participant) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: participant.isSpeaking 
            ? AppTheme.moroccoGreen.withValues(alpha: 0.2)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: participant.isSpeaking 
              ? AppTheme.moroccoGreen 
              : Colors.grey.shade300,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 8,
            backgroundImage: NetworkImage(participant.userAvatar),
          ),
          const SizedBox(width: 4),
          Text(
            participant.userName,
            style: TextStyle(
              fontSize: 11,
              fontWeight: participant.isSpeaking ? FontWeight.w600 : FontWeight.normal,
              color: participant.isSpeaking ? AppTheme.moroccoGreen : AppTheme.primaryText,
            ),
          ),
          if (participant.isMuted) ...[
            const SizedBox(width: 2),
            const Icon(
              Icons.mic_off,
              size: 10,
              color: Colors.red,
            ),
          ],
          if (participant.isSpeaking) ...[
            const SizedBox(width: 2),
            const Icon(
              Icons.volume_up,
              size: 10,
              color: AppTheme.moroccoGreen,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVoiceControls() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.moroccoGreen),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.call,
            color: AppTheme.moroccoGreen,
            size: 20,
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Voice connected',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppTheme.moroccoGreen,
              ),
            ),
          ),
          
          // Mute toggle
          IconButton(
            onPressed: _toggleMute,
            icon: Icon(
              _isMuted ? Icons.mic_off : Icons.mic,
              color: _isMuted ? Colors.red : AppTheme.moroccoGreen,
            ),
            tooltip: _isMuted ? 'Unmute' : 'Mute',
          ),
          
          // Leave channel
          IconButton(
            onPressed: _leaveVoiceChannel,
            icon: const Icon(
              Icons.call_end,
              color: Colors.red,
            ),
            tooltip: 'Leave channel',
          ),
        ],
      ),
    );
  }
}