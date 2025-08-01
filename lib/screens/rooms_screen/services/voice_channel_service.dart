import 'dart:async';
import 'package:deadhour/utils/mock_data.dart';







/// Voice channel service for community audio features
/// Addresses critical missing voice/video channels from TAB_ANALYSIS_REPORT.md
class VoiceChannelService {
  static final VoiceChannelService _instance = VoiceChannelService._internal();
  factory VoiceChannelService() => _instance;
  VoiceChannelService._internal();

  // Voice channel state
  final Map<String, VoiceChannel> _voiceChannels = {};
  final Map<String, List<VoiceParticipant>> _channelParticipants = {};
  bool _isInitialized = false;

  /// Initialize voice service with sample data
  void initializeVoiceService() {
    if (_isInitialized) return;
    
    _generateSampleVoiceChannels();
    _isInitialized = true;
  }

  /// Get voice channels for a room
  List<VoiceChannel> getRoomVoiceChannels(String roomId) {
    return _voiceChannels.values
        .where((channel) => channel.roomId == roomId)
        .toList()
        ..sort((a, b) => b.activeParticipants.compareTo(a.activeParticipants));
  }

  /// Get participants in a voice channel
  List<VoiceParticipant> getChannelParticipants(String channelId) {
    return _channelParticipants[channelId] ?? [];
  }

  /// Join a voice channel
  Future<VoiceChannelResult> joinVoiceChannel(String channelId, String userId) async {
    final channel = _voiceChannels[channelId];
    if (channel == null) {
      return const VoiceChannelResult(
        success: false,
        message: 'Voice channel not found',
      );
    }

    // Check channel capacity
    final participants = _channelParticipants[channelId] ?? [];
    if (participants.length >= channel.maxParticipants) {
      return VoiceChannelResult(
        success: false,
        message: 'Voice channel is full (${channel.maxParticipants} participants)',
      );
    }

    // Check if user already in channel
    if (participants.any((p) => p.userId == userId)) {
      return const VoiceChannelResult(
        success: false,
        message: 'Already in voice channel',
      );
    }

    // Add participant
    final participant = VoiceParticipant(
      userId: userId,
      userName: 'User $userId',
      userAvatar: 'https://picsum.photos/50/50?random=$userId',
      joinedAt: DateTime.now(),
      isMuted: false,
      isSpeaking: false,
      connectionQuality: VoiceQuality.good,
    );

    _channelParticipants[channelId] = [...participants, participant];
    
    // Update channel stats
    _voiceChannels[channelId] = channel.copyWith(
      activeParticipants: participants.length + 1,
    );

    return VoiceChannelResult(
      success: true,
      message: 'Joined voice channel successfully',
      participant: participant,
    );
  }

  /// Leave a voice channel
  Future<VoiceChannelResult> leaveVoiceChannel(String channelId, String userId) async {
    final participants = _channelParticipants[channelId] ?? [];
    final updatedParticipants = participants.where((p) => p.userId != userId).toList();
    
    _channelParticipants[channelId] = updatedParticipants;
    
    // Update channel stats
    final channel = _voiceChannels[channelId];
    if (channel != null) {
      _voiceChannels[channelId] = channel.copyWith(
        activeParticipants: updatedParticipants.length,
      );
    }

    return const VoiceChannelResult(
      success: true,
      message: 'Left voice channel successfully',
    );
  }

  /// Toggle participant mute status
  Future<bool> toggleMute(String channelId, String userId) async {
    final participants = _channelParticipants[channelId] ?? [];
    final participantIndex = participants.indexWhere((p) => p.userId == userId);
    
    if (participantIndex == -1) return false;
    
    final participant = participants[participantIndex];
    final updatedParticipant = participant.copyWith(isMuted: !participant.isMuted);
    
    participants[participantIndex] = updatedParticipant;
    _channelParticipants[channelId] = participants;
    
    return updatedParticipant.isMuted;
  }

  /// Create a new voice channel
  Future<VoiceChannel?> createVoiceChannel({
    required String roomId,
    required String name,
    required String creatorId,
    int maxParticipants = 20,
    VoiceChannelType type = VoiceChannelType.general,
  }) async {
    final channelId = 'voice_${DateTime.now().millisecondsSinceEpoch}';
    
    final channel = VoiceChannel(
      id: channelId,
      roomId: roomId,
      name: name,
      type: type,
      createdBy: creatorId,
      createdAt: DateTime.now(),
      maxParticipants: maxParticipants,
      activeParticipants: 0,
      isActive: true,
    );

    _voiceChannels[channelId] = channel;
    _channelParticipants[channelId] = [];
    
    return channel;
  }

  void _generateSampleVoiceChannels() {
    final rooms = MockData.rooms;
    
    for (final room in rooms.take(5)) {
      // General voice channel for each room
      final generalChannel = VoiceChannel(
        id: 'voice_general_${room.id}',
        roomId: room.id,
        name: 'General Voice',
        type: VoiceChannelType.general,
        createdBy: 'system',
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        maxParticipants: 20,
        activeParticipants: (room.id.hashCode % 8) + 1,
        isActive: true,
      );
      
      _voiceChannels[generalChannel.id] = generalChannel;
      _generateSampleParticipants(generalChannel.id, generalChannel.activeParticipants);
      
      // Deal discussion voice channel for business rooms
      if (room.category == 'food' || room.category == 'entertainment') {
        final dealChannel = VoiceChannel(
          id: 'voice_deals_${room.id}',
          roomId: room.id,
          name: 'Deal Discussions',
          type: VoiceChannelType.dealDiscussion,
          createdBy: 'business_owner',
          createdAt: DateTime.now().subtract(const Duration(hours: 3)),
          maxParticipants: 15,
          activeParticipants: (room.id.hashCode % 5) + 1,
          isActive: true,
        );
        
        _voiceChannels[dealChannel.id] = dealChannel;
        _generateSampleParticipants(dealChannel.id, dealChannel.activeParticipants);
      }
      
      // Cultural discussion for relevant rooms
      if (room.category == 'tourism' || room.isPrayerTimeAware) {
        final culturalChannel = VoiceChannel(
          id: 'voice_cultural_${room.id}',
          roomId: room.id,
          name: 'Cultural Exchange',
          type: VoiceChannelType.cultural,
          createdBy: 'guide_expert',
          createdAt: DateTime.now().subtract(const Duration(hours: 12)),
          maxParticipants: 12,
          activeParticipants: (room.id.hashCode % 4) + 1,
          isActive: true,
        );
        
        _voiceChannels[culturalChannel.id] = culturalChannel;
        _generateSampleParticipants(culturalChannel.id, culturalChannel.activeParticipants);
      }
    }
  }

  void _generateSampleParticipants(String channelId, int count) {
    final participants = <VoiceParticipant>[];
    
    for (int i = 0; i < count; i++) {
      final userId = 'user_$channelId$i';
      participants.add(VoiceParticipant(
        userId: userId,
        userName: _getSampleUserName(i),
        userAvatar: 'https://picsum.photos/50/50?random=${userId.hashCode}',
        joinedAt: DateTime.now().subtract(Duration(minutes: (count - i) * 5)),
        isMuted: i % 4 == 0, // 25% chance of being muted
        isSpeaking: i == 0, // First user is speaking
        connectionQuality: VoiceQuality.values[i % VoiceQuality.values.length],
      ));
    }
    
    _channelParticipants[channelId] = participants;
  }

  String _getSampleUserName(int index) {
    final names = [
      'Ahmed K.', 'Sarah M.', 'Youssef A.', 'Fatima R.',
      'Hassan B.', 'Aicha L.', 'Omar T.', 'Khadija N.',
      'Mohamed S.', 'Laila H.', 'Karim D.', 'Zineb F.'
    ];
    return names[index % names.length];
  }
}

