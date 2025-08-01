

extension VoiceChannelTypeExtension on VoiceChannelType {
  String get displayName {
    switch (this) {
      case VoiceChannelType.general:
        return 'General';
      case VoiceChannelType.dealDiscussion:
        return 'Deal Discussion';
      case VoiceChannelType.cultural:
        return 'Cultural Exchange';
      case VoiceChannelType.businessOnly:
        return 'Business Only';
      case VoiceChannelType.guideNetwork:
        return 'Guide Network';
    }
  }

  String get icon {
    switch (this) {
      case VoiceChannelType.general:
        return '🎙️';
      case VoiceChannelType.dealDiscussion:
        return '💰';
      case VoiceChannelType.cultural:
        return '🕌';
      case VoiceChannelType.businessOnly:
        return '🏢';
      case VoiceChannelType.guideNetwork:
        return '🗺️';
    }
  }
}