import 'voice_channel_type.dart';

/// Voice channel model
class VoiceChannel {
  final String id;
  final String roomId;
  final String name;
  final VoiceChannelType type;
  final String createdBy;
  final DateTime createdAt;
  final int maxParticipants;
  final int activeParticipants;
  final bool isActive;

  const VoiceChannel({
    required this.id,
    required this.roomId,
    required this.name,
    required this.type,
    required this.createdBy,
    required this.createdAt,
    required this.maxParticipants,
    required this.activeParticipants,
    required this.isActive,
  });

  VoiceChannel copyWith({
    String? id,
    String? roomId,
    String? name,
    VoiceChannelType? type,
    String? createdBy,
    DateTime? createdAt,
    int? maxParticipants,
    int? activeParticipants,
    bool? isActive,
  }) {
    return VoiceChannel(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      name: name ?? this.name,
      type: type ?? this.type,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      activeParticipants: activeParticipants ?? this.activeParticipants,
      isActive: isActive ?? this.isActive,
    );
  }
}