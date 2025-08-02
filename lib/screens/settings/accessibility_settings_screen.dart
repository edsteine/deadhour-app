import 'package:flutter/material.dart';
import 'package:deadhour/services/accessibility_service.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/widgets/common/dead_hour_app_bar.dart';

class AccessibilitySettingsScreen extends StatefulWidget {
  const AccessibilitySettingsScreen({super.key});

  @override
  State<AccessibilitySettingsScreen> createState() => _AccessibilitySettingsScreenState();
}

class _AccessibilitySettingsScreenState extends State<AccessibilitySettingsScreen> {
  final _accessibilityService = AccessibilityService();
  late Map<String, dynamic> _settings;

  @override
  void initState() {
    super.initState();
    _settings = _accessibilityService.getAccessibilitySettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DeadHourAppBar(
        title: 'Accessibility Settings',
        showBackButton: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        children: [
          _buildVisionSection(),
          const SizedBox(height: AppTheme.spacing24),
          _buildMotionSection(),
          const SizedBox(height: AppTheme.spacing24),
          _buildInteractionSection(),
          const SizedBox(height: AppTheme.spacing24),
          _buildLanguageSection(),
          const SizedBox(height: AppTheme.spacing24),
          _buildTestSection(),
        ],
      ),
    );
  }

  Widget _buildVisionSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.visibility,
                  color: AppTheme.moroccoGreen,
                  size: 24 * _accessibilityService.textScaleFactor,
                ),
                const SizedBox(width: AppTheme.spacing12),
                Text(
                  'Vision',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: (Theme.of(context).textTheme.titleLarge?.fontSize ?? 20) * 
                             _accessibilityService.textScaleFactor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            // High Contrast Toggle
            Semantics(
              label: 'High contrast mode toggle, ${_settings['high_contrast'] ? 'enabled' : 'disabled'}',
              child: SwitchListTile(
                title: Text(
                  'High Contrast',
                  style: TextStyle(
                    fontSize: 16 * _accessibilityService.textScaleFactor,
                  ),
                ),
                subtitle: Text(
                  'Improves text and UI element visibility',
                  style: TextStyle(
                    fontSize: 14 * _accessibilityService.textScaleFactor,
                  ),
                ),
                value: _settings['high_contrast'] ?? false,
                onChanged: (value) {
                  setState(() {
                    _settings['high_contrast'] = value;
                  });
                  _accessibilityService.setHighContrast(value);
                  _accessibilityService.announceAction(
                    value ? 'High contrast enabled' : 'High contrast disabled'
                  );
                },
              ),
            ),
            
            // Large Text Toggle
            Semantics(
              label: 'Large text toggle, ${_settings['large_text'] ? 'enabled' : 'disabled'}',
              child: SwitchListTile(
                title: Text(
                  'Large Text',
                  style: TextStyle(
                    fontSize: 16 * _accessibilityService.textScaleFactor,
                  ),
                ),
                subtitle: Text(
                  'Increases text size throughout the app',
                  style: TextStyle(
                    fontSize: 14 * _accessibilityService.textScaleFactor,
                  ),
                ),
                value: _settings['large_text'] ?? false,
                onChanged: (value) {
                  setState(() {
                    _settings['large_text'] = value;
                  });
                  _accessibilityService.setLargeText(value);
                  _accessibilityService.announceAction(
                    value ? 'Large text enabled' : 'Large text disabled'
                  );
                },
              ),
            ),
            
            // Text Scale Factor Slider
            Semantics(
              label: 'Text size slider, current value ${(_settings['text_scale_factor'] * 100).round()}%',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Text Size: ${(_settings['text_scale_factor'] * 100).round()}%',
                    style: TextStyle(
                      fontSize: 16 * _accessibilityService.textScaleFactor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Slider(
                    value: _settings['text_scale_factor']?.toDouble() ?? 1.0,
                    min: 0.8,
                    max: 2.0,
                    divisions: 12,
                    label: '${(_settings['text_scale_factor'] * 100).round()}%',
                    onChanged: (value) {
                      setState(() {
                        _settings['text_scale_factor'] = value;
                      });
                      _accessibilityService.setTextScaleFactor(value);
                    },
                    onChangeEnd: (value) {
                      _accessibilityService.announceAction(
                        'Text size set to ${(value * 100).round()}%'
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMotionSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.motion_photos_off,
                  color: AppTheme.moroccoGreen,
                  size: 24 * _accessibilityService.textScaleFactor,
                ),
                const SizedBox(width: AppTheme.spacing12),
                Text(
                  'Motion',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: (Theme.of(context).textTheme.titleLarge?.fontSize ?? 20) * 
                             _accessibilityService.textScaleFactor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            // Reduce Motion Toggle
            Semantics(
              label: 'Reduce motion toggle, ${_settings['reduce_motion'] ? 'enabled' : 'disabled'}',
              child: SwitchListTile(
                title: Text(
                  'Reduce Motion',
                  style: TextStyle(
                    fontSize: 16 * _accessibilityService.textScaleFactor,
                  ),
                ),
                subtitle: Text(
                  'Minimizes animations and motion effects',
                  style: TextStyle(
                    fontSize: 14 * _accessibilityService.textScaleFactor,
                  ),
                ),
                value: _settings['reduce_motion'] ?? false,
                onChanged: (value) {
                  setState(() {
                    _settings['reduce_motion'] = value;
                  });
                  _accessibilityService.setReduceMotion(value);
                  _accessibilityService.announceAction(
                    value ? 'Motion reduction enabled' : 'Motion reduction disabled'
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractionSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.touch_app,
                  color: AppTheme.moroccoGreen,
                  size: 24 * _accessibilityService.textScaleFactor,
                ),
                const SizedBox(width: AppTheme.spacing12),
                Text(
                  'Interaction',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: (Theme.of(context).textTheme.titleLarge?.fontSize ?? 20) * 
                             _accessibilityService.textScaleFactor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            // Screen Reader Hints Toggle
            Semantics(
              label: 'Screen reader hints toggle, ${_settings['screen_reader_hints'] ? 'enabled' : 'disabled'}',
              child: SwitchListTile(
                title: Text(
                  'Screen Reader Hints',
                  style: TextStyle(
                    fontSize: 16 * _accessibilityService.textScaleFactor,
                  ),
                ),
                subtitle: Text(
                  'Provides additional context for screen readers',
                  style: TextStyle(
                    fontSize: 14 * _accessibilityService.textScaleFactor,
                  ),
                ),
                value: _settings['screen_reader_hints'] ?? true,
                onChanged: (value) {
                  setState(() {
                    _settings['screen_reader_hints'] = value;
                  });
                  _accessibilityService.setScreenReader(value);
                  _accessibilityService.announceAction(
                    value ? 'Screen reader hints enabled' : 'Screen reader hints disabled'
                  );
                },
              ),
            ),
            
            // Haptic Feedback Toggle
            Semantics(
              label: 'Haptic feedback toggle, ${_settings['haptic_feedback'] ? 'enabled' : 'disabled'}',
              child: SwitchListTile(
                title: Text(
                  'Haptic Feedback',
                  style: TextStyle(
                    fontSize: 16 * _accessibilityService.textScaleFactor,
                  ),
                ),
                subtitle: Text(
                  'Vibration feedback for interactions',
                  style: TextStyle(
                    fontSize: 14 * _accessibilityService.textScaleFactor,
                  ),
                ),
                value: _settings['haptic_feedback'] ?? true,
                onChanged: (value) {
                  setState(() {
                    _settings['haptic_feedback'] = value;
                  });
                  _accessibilityService.updateAccessibilitySettings({
                    'haptic_feedback': value,
                  });
                  if (value) {
                    _accessibilityService.accessibilityFeedback();
                  }
                  _accessibilityService.announceAction(
                    value ? 'Haptic feedback enabled' : 'Haptic feedback disabled'
                  );
                },
              ),
            ),
            
            // Semantic Descriptions Toggle
            Semantics(
              label: 'Semantic descriptions toggle, ${_settings['semantic_descriptions'] ? 'enabled' : 'disabled'}',
              child: SwitchListTile(
                title: Text(
                  'Detailed Descriptions',
                  style: TextStyle(
                    fontSize: 16 * _accessibilityService.textScaleFactor,
                  ),
                ),
                subtitle: Text(
                  'Provides detailed semantic information',
                  style: TextStyle(
                    fontSize: 14 * _accessibilityService.textScaleFactor,
                  ),
                ),
                value: _settings['semantic_descriptions'] ?? true,
                onChanged: (value) {
                  setState(() {
                    _settings['semantic_descriptions'] = value;
                  });
                  _accessibilityService.updateAccessibilitySettings({
                    'semantic_descriptions': value,
                  });
                  _accessibilityService.announceAction(
                    value ? 'Detailed descriptions enabled' : 'Detailed descriptions disabled'
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.language,
                  color: AppTheme.moroccoGreen,
                  size: 24 * _accessibilityService.textScaleFactor,
                ),
                const SizedBox(width: AppTheme.spacing12),
                Text(
                  'Language & Region',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: (Theme.of(context).textTheme.titleLarge?.fontSize ?? 20) * 
                             _accessibilityService.textScaleFactor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            ListTile(
              leading: const Icon(Icons.format_textdirection_r_to_l),
              title: Text(
                'Right-to-Left Languages',
                style: TextStyle(
                  fontSize: 16 * _accessibilityService.textScaleFactor,
                ),
              ),
              subtitle: Text(
                'Arabic text direction support enabled',
                style: TextStyle(
                  fontSize: 14 * _accessibilityService.textScaleFactor,
                ),
              ),
              trailing: const Icon(
                Icons.check_circle,
                color: AppTheme.moroccoGreen,
              ),
            ),
            
            ListTile(
              leading: const Icon(Icons.accessibility_new),
              title: Text(
                'Cultural Accessibility',
                style: TextStyle(
                  fontSize: 16 * _accessibilityService.textScaleFactor,
                ),
              ),
              subtitle: Text(
                'Prayer times and cultural context support',
                style: TextStyle(
                  fontSize: 14 * _accessibilityService.textScaleFactor,
                ),
              ),
              trailing: const Icon(
                Icons.check_circle,
                color: AppTheme.moroccoGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.science,
                  color: AppTheme.moroccoGreen,
                  size: 24 * _accessibilityService.textScaleFactor,
                ),
                const SizedBox(width: AppTheme.spacing12),
                Text(
                  'Test Accessibility',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: (Theme.of(context).textTheme.titleLarge?.fontSize ?? 20) * 
                             _accessibilityService.textScaleFactor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            // Test Voice Announcement
            Semantics(
              label: 'Test voice announcement button',
              child: ElevatedButton.icon(
                onPressed: () {
                  _accessibilityService.announceAction(
                    'Accessibility test: Voice announcements are working correctly'
                  );
                  _accessibilityService.accessibilityFeedback();
                },
                icon: const Icon(Icons.record_voice_over),
                label: Text(
                  'Test Voice Announcement',
                  style: TextStyle(
                    fontSize: 14 * _accessibilityService.textScaleFactor,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: AppTheme.spacing12),
            
            // Test Haptic Feedback
            Semantics(
              label: 'Test haptic feedback button',
              child: OutlinedButton.icon(
                onPressed: () {
                  _accessibilityService.accessibilityFeedback();
                  _accessibilityService.announceAction('Haptic feedback test complete');
                },
                icon: const Icon(Icons.vibration),
                label: Text(
                  'Test Haptic Feedback',
                  style: TextStyle(
                    fontSize: 14 * _accessibilityService.textScaleFactor,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: AppTheme.spacing16),
            
            // Accessibility Guidelines
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing12),
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Accessibility Tips',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: (Theme.of(context).textTheme.titleSmall?.fontSize ?? 14) * 
                               _accessibilityService.textScaleFactor,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing8),
                  Text(
                    '• Enable TalkBack (Android) or VoiceOver (iOS) for screen reading\n'
                    '• Use high contrast mode in bright environments\n'
                    '• Adjust text size for comfortable reading\n'
                    '• Enable haptic feedback for better interaction feedback',
                    style: TextStyle(
                      fontSize: 12 * _accessibilityService.textScaleFactor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}