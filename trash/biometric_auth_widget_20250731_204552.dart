import 'package:flutter/material.dart';
import '../../services/biometric_auth_service.dart';
import '../../utils/theme.dart';

/// Biometric authentication settings widget
/// Provides comprehensive biometric security management
class BiometricAuthWidget extends StatefulWidget {
  final String userId;
  final VoidCallback? onAuthChanged;

  const BiometricAuthWidget({
    super.key,
    required this.userId,
    this.onAuthChanged,
  });

  @override
  State<BiometricAuthWidget> createState() => _BiometricAuthWidgetState();
}

class _BiometricAuthWidgetState extends State<BiometricAuthWidget> {
  final BiometricAuthService _biometricService = BiometricAuthService();
  
  BiometricAvailability? _availability;
  BiometricPreferences? _preferences;
  BiometricSecurityStatus? _securityStatus;
  bool _isLoading = true;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _initializeBiometricAuth();
  }

  Future<void> _initializeBiometricAuth() async {
    await _biometricService.initializeBiometricAuth();
    await _loadBiometricData();
  }

  Future<void> _loadBiometricData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final availability = await _biometricService.checkBiometricAvailability();
      final preferences = await _biometricService.getBiometricPreferences(widget.userId);
      final securityStatus = _biometricService.getSecurityStatus(widget.userId);

      setState(() {
        _availability = availability;
        _preferences = preferences;
        _securityStatus = securityStatus;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showError('Failed to load biometric settings: ${e.toString()}');
    }
  }

  Future<void> _toggleBiometricAuth(bool enable) async {
    if (_availability == null || _preferences == null) return;

    setState(() {
      _isUpdating = true;
    });

    try {
      if (enable) {
        if (!_availability!.hasEnrolledBiometrics) {
          _showBiometricEnrollmentDialog();
          setState(() {
            _isUpdating = false;
          });
          return;
        }

        final result = await _biometricService.enableBiometricAuth(
          userId: widget.userId,
          type: _availability!.recommendedMethod ?? BiometricType.fingerprint,
          customReason: 'Enable biometric login for your DeadHour account',
        );

        if (result.success) {
          await _loadBiometricData();
          widget.onAuthChanged?.call();
          _showSuccess('Biometric authentication enabled successfully');
        } else {
          _showError(result.message);
          if (result.requiresEnrollment) {
            _showBiometricEnrollmentDialog();
          }
        }
      } else {
        final disabled = await _biometricService.disableBiometricAuth(widget.userId);
        if (disabled) {
          await _loadBiometricData();
          widget.onAuthChanged?.call();
          _showSuccess('Biometric authentication disabled');
        }
      }
    } catch (e) {
      _showError('Failed to update biometric settings: ${e.toString()}');
    }

    setState(() {
      _isUpdating = false;
    });
  }

  Future<void> _updatePreferences(BiometricPreferences newPrefs) async {
    setState(() {
      _isUpdating = true;
    });

    try {
      await _biometricService.updateBiometricPreferences(
        userId: widget.userId,
        preferences: newPrefs,
      );
      
      await _loadBiometricData();
      widget.onAuthChanged?.call();
      _showSuccess('Biometric preferences updated');
    } catch (e) {
      _showError('Failed to update preferences: ${e.toString()}');
    }

    setState(() {
      _isUpdating = false;
    });
  }

  void _testBiometricAuth() async {
    try {
      final result = await _biometricService.requireFreshAuthentication(
        reason: 'Test your biometric authentication',
        preferredType: _preferences?.preferredType,
      );

      if (result.success) {
        _showSuccess('Biometric authentication test successful!');
        await _loadBiometricData(); // Refresh status
      } else {
        _showError('Biometric test failed: ${result.message}');
      }
    } catch (e) {
      _showError('Test failed: ${e.toString()}');
    }
  }

  void _showBiometricEnrollmentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.fingerprint,
          color: AppTheme.moroccoGreen,
          size: 48,
        ),
        title: const Text('Biometric Setup Required'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'To use biometric authentication, you need to set up your fingerprint or face recognition in your device settings first.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Go to Settings > Security > Biometrics to enroll your biometrics.',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.secondaryText,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // In real app, open device settings
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.moroccoGreen,
              foregroundColor: Colors.white,
            ),
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildLoadingState();
    }

    if (_availability == null || !_availability!.isAvailable) {
      return _buildUnavailableState();
    }

    return _buildBiometricSettings();
  }

  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Column(
        children: [
          CircularProgressIndicator(color: AppTheme.moroccoGreen),
          SizedBox(height: 16),
          Text(
            'Checking biometric capabilities...',
            style: TextStyle(color: AppTheme.secondaryText),
          ),
        ],
      ),
    );
  }

  Widget _buildUnavailableState() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.fingerprint_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          const Text(
            'Biometric Authentication Unavailable',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryText,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            _availability == null 
                ? 'Unable to check biometric capabilities'
                : 'This device does not support biometric authentication',
            style: const TextStyle(
              color: AppTheme.secondaryText,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBiometricSettings() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          if (_securityStatus != null) _buildSecurityStatus(),
          const SizedBox(height: 16),
          _buildMainToggle(),
          if (_preferences?.isEnabled == true) ...[
            const SizedBox(height: 20),
            _buildAdvancedSettings(),
          ],
          const SizedBox(height: 20),
          _buildTestSection(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            _getMainBiometricIcon(),
            color: AppTheme.moroccoGreen,
            size: 28,
          ),
        ),
        const SizedBox(width: 16),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Biometric Security',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryText,
                ),
              ),
              Text(
                'Secure your account with fingerprint or face recognition',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.secondaryText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityStatus() {
    final status = _securityStatus!;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: status.isAuthValid 
            ? Colors.green.withValues(alpha: 0.1)
            : Colors.orange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: status.isAuthValid ? Colors.green : Colors.orange,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            status.isAuthValid ? Icons.verified_user : Icons.schedule,
            color: status.isAuthValid ? Colors.green : Colors.orange,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status.isAuthValid 
                      ? 'Authentication Valid'
                      : 'Re-authentication Required',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: status.isAuthValid ? Colors.green : Colors.orange,
                  ),
                ),
                if (status.lastAuthTime != null)
                  Text(
                    'Last authenticated: ${_formatTime(status.lastAuthTime!)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.secondaryText,
                    ),
                  ),
                if (status.failedAttempts > 0)
                  Text(
                    'Failed attempts: ${status.failedAttempts}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainToggle() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enable Biometric Authentication',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _preferences?.isEnabled == true
                      ? 'Biometric login is active'
                      : 'Use your biometrics to sign in securely',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.secondaryText,
                  ),
                ),
              ],
            ),
          ),
          if (_isUpdating)
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppTheme.moroccoGreen,
              ),
            )
          else
            Switch(
              value: _preferences?.isEnabled ?? false,
              onChanged: _toggleBiometricAuth,
              activeColor: AppTheme.moroccoGreen,
            ),
        ],
      ),
    );
  }

  Widget _buildAdvancedSettings() {
    if (_preferences == null || !_preferences!.isEnabled) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Security Options',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.primaryText,
          ),
        ),
        const SizedBox(height: 12),
        _buildPreferenceToggle(
          title: 'Require for Login',
          subtitle: 'Use biometrics to sign in to your account',
          value: _preferences!.requireForLogin,
          onChanged: (value) => _updatePreferences(
            _preferences!.copyWith(requireForLogin: value),
          ),
        ),
        _buildPreferenceToggle(
          title: 'Require for Payments',
          subtitle: 'Verify identity before making payments',
          value: _preferences!.requireForPayments,
          onChanged: (value) => _updatePreferences(
            _preferences!.copyWith(requireForPayments: value),
          ),
        ),
        _buildPreferenceToggle(
          title: 'Require for Sensitive Actions',
          subtitle: 'Verify identity for account changes',
          value: _preferences!.requireForSensitiveActions,
          onChanged: (value) => _updatePreferences(
            _preferences!.copyWith(requireForSensitiveActions: value),
          ),
        ),
        _buildPreferenceToggle(
          title: 'Allow Password Fallback',
          subtitle: 'Use password if biometric fails',
          value: _preferences!.fallbackToPassword,
          onChanged: (value) => _updatePreferences(
            _preferences!.copyWith(fallbackToPassword: value),
          ),
        ),
      ],
    );
  }

  Widget _buildPreferenceToggle({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.primaryText,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.secondaryText,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: _isUpdating ? null : onChanged,
            activeColor: AppTheme.moroccoGreen,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }

  Widget _buildTestSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Test Authentication',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.primaryText,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Test your biometric authentication to ensure it\'s working properly.',
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.secondaryText,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: (_preferences?.isEnabled == true && !_isUpdating)
                ? _testBiometricAuth
                : null,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.moroccoGreen,
              side: const BorderSide(color: AppTheme.moroccoGreen),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            icon: const Icon(Icons.fingerprint),
            label: const Text('Test Biometric Authentication'),
          ),
        ),
      ],
    );
  }

  IconData _getMainBiometricIcon() {
    if (_availability?.recommendedMethod == BiometricType.face) {
      return Icons.face;
    }
    return Icons.fingerprint;
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}