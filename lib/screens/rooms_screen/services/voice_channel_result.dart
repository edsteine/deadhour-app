

/// Voice channel operation result
class VoiceChannelResult {
  final bool success;
  final String message;
  final VoiceParticipant? participant;

  const VoiceChannelResult({
    required this.success,
    required this.message,
    this.participant,
  });
}