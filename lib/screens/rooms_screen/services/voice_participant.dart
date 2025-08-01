

/// Voice channel participant
class VoiceParticipant {
  final String userId;
  final String userName;
  final String userAvatar;
  final DateTime joinedAt;
  final bool isMuted;
  final bool isSpeaking;
  final VoiceQuality connectionQuality;

  const VoiceParticipant({
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.joinedAt,
    required this.isMuted,
    required this.isSpeaking,
    required this.connectionQuality,
  });

  VoiceParticipant copyWith({
    String? userId,
    String? userName,
    String? userAvatar,
    DateTime? joinedAt,
    bool? isMuted,
    bool? isSpeaking,
    VoiceQuality? connectionQuality,
  }) {
    return VoiceParticipant(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      joinedAt: joinedAt ?? this.joinedAt,
      isMuted: isMuted ?? this.isMuted,
      isSpeaking: isSpeaking ?? this.isSpeaking,
      connectionQuality: connectionQuality ?? this.connectionQuality,
    );
  }
}