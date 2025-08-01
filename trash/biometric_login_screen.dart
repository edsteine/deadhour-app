import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../lib/services/biometric_auth_service.dart';
import '../lib/utils/theme.dart';

/// Biometric login screen for secure authentication
/// Provides fingerprint and face recognition login options
class BiometricLoginScreen extends StatefulWidget {
  final String? redirectPath;

  const BiometricLoginScreen({
    super.key,
    this.redirectPath,
  });

  @override
  State<BiometricLoginScreen> createState() => _BiometricLoginScreenState();
}

class _BiometricLoginScreenState extends State<BiometricLoginScreen>
    with TickerProviderStateMixin {
  final BiometricAuthService _biometricService = BiometricAuthService();

  BiometricAvailability? _availability;
  bool _isLoading = true;
  bool _isAuthenticating = false;
  String? _errorMessage;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeBiometric();
  }

  void _initializeAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    _pulseController.repeat(reverse: true);
  }

  Future<void> _initializeBiometric() async {
    await _biometricService.initializeBiometricAuth();
    final availability = await _biometricService.checkBiometricAvailability();

    setState(() {
      _availability = availability;
      _isLoading = false;
    });

    // Auto-trigger authentication if available
    if (availability.isAvailable && availability.hasEnrolledBiometrics) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _authenticateWithBiometrics();
      });
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    if (_isAuthenticating || _availability == null) return;

    setState(() {
      _isAuthenticating = true;
      _errorMessage = null;
    });

    try {
      final result = await _biometricService.authenticateWithBiometrics(
        reason: 'Sign in to your DeadHour account',
        preferredType: _availability!.recommendedMethod,
      );

      if (result.success) {
        _handleSuccessfulLogin();
      } else {
        setState(() {
          _errorMessage = result.message;
          _isAuthenticating = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Authentication failed: ${e.toString()}';
        _isAuthenticating = false;
      });
    }
  }

  void _handleSuccessfulLogin() {
    // Show success animation
    _showSuccessAnimation();

    // Navigate after delay
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        if (widget.redirectPath != null) {
          context.go(widget.redirectPath!);
        } else {
          context.go('/home');
        }
      }
    });
  }

  void _showSuccessAnimation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const BiometricSuccessDialog(),
    );
  }

  void _fallbackToPassword() {
    context.go('/login');
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Header
              _buildHeader(),
              
              const SizedBox(height: 60),

              // Main content
              Expanded(
                child: _isLoading 
                    ? _buildLoadingState()
                    : _availability?.isAvailable == true
                        ? _buildBiometricAuth()
                        : _buildUnavailableState(),
              ),

              // Footer
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back, color: AppTheme.secondaryText),
            ),
            const Spacer(),
            const Text(
              'Secure Login',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryText,
              ),
            ),
            const Spacer(),
            const SizedBox(width: 48), // Balance the back button
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.security,
            size: 32,
            color: AppTheme.moroccoGreen,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Welcome back!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryText,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Use your biometric to sign in securely',
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.secondaryText,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppTheme.moroccoGreen),
          SizedBox(height: 20),
          Text(
            'Initializing biometric authentication...',
            style: TextStyle(color: AppTheme.secondaryText),
          ),
        ],
      ),
    );
  }

  Widget _buildBiometricAuth() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Biometric icon with animation
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _isAuthenticating ? _pulseAnimation.value : 1.0,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: _isAuthenticating 
                        ? AppTheme.moroccoGreen.withValues(alpha: 0.1)
                        : Colors.grey.shade100,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _isAuthenticating 
                          ? AppTheme.moroccoGreen 
                          : Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    _getBiometricIcon(),
                    size: 60,
                    color: _isAuthenticating 
                        ? AppTheme.moroccoGreen 
                        : Colors.grey.shade600,
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 32),

          // Status text
          Text(
            _getStatusText(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: _errorMessage != null ? Colors.red : AppTheme.primaryText,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),

          if (_errorMessage != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ] else ...[
            Text(
              _getInstructionText(),
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.secondaryText,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
          ],

          // Action buttons
          if (!_isAuthenticating) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _authenticateWithBiometrics,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.moroccoGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: Icon(_getBiometricIcon()),
                label: Text('Authenticate with ${_getBiometricName()}'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _fallbackToPassword,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.secondaryText,
                  side: BorderSide(color: Colors.grey.shade300),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.password),
                label: const Text('Use Password Instead'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildUnavailableState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.fingerprint_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 24),
          const Text(
            'Biometric Authentication\nUnavailable',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryText,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            _availability?.hasEnrolledBiometrics == false
                ? 'Please set up your biometrics in device settings'
                : 'This device does not support biometric authentication',
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.secondaryText,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _fallbackToPassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.moroccoGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.password),
              label: const Text('Continue with Password'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        const Divider(),
        const SizedBox(height: 16),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.security, size: 16, color: AppTheme.secondaryText),
            SizedBox(width: 8),
            Text(
              'Your biometric data stays secure on your device',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.secondaryText,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const BiometricInfoDialog(),
            );
          },
          child: const Text(
            'Learn more about biometric security',
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.moroccoGreen,
            ),
          ),
        ),
      ],
    );
  }

  IconData _getBiometricIcon() {
    if (_availability?.recommendedMethod == BiometricType.face) {
      return Icons.face;
    }
    return Icons.fingerprint;
  }

  String _getBiometricName() {
    if (_availability?.recommendedMethod == BiometricType.face) {
      return 'Face Recognition';
    }
    return 'Fingerprint';
  }

  String _getStatusText() {
    if (_errorMessage != null) {
      return 'Authentication Failed';
    }
    if (_isAuthenticating) {
      return 'Authenticating...';
    }
    return 'Ready to Authenticate';
  }

  String _getInstructionText() {
    if (_isAuthenticating) {
      if (_availability?.recommendedMethod == BiometricType.face) {
        return 'Look at your device to sign in';
      }
      return 'Touch the fingerprint sensor';
    }
    return 'Tap the button below to start authentication';
  }
}

/// Success dialog shown after successful biometric authentication
class BiometricSuccessDialog extends StatefulWidget {
  const BiometricSuccessDialog({super.key});

  @override
  State<BiometricSuccessDialog> createState() => _BiometricSuccessDialogState();
}

class _BiometricSuccessDialogState extends State<BiometricSuccessDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 64,
                    color: Colors.green,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Authentication Successful!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Signing you in...',
                    style: TextStyle(
                      color: AppTheme.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Information dialog about biometric security
class BiometricInfoDialog extends StatelessWidget {
  const BiometricInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.info_outline, color: AppTheme.moroccoGreen),
          SizedBox(width: 8),
          Text('Biometric Security'),
        ],
      ),
      content: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'How we protect your biometric data:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12),
            Text('• Your biometric data never leaves your device'),
            SizedBox(height: 8),
            Text('• Authentication happens locally using secure hardware'),
            SizedBox(height: 8),
            Text('• We only receive confirmation of successful authentication'),
            SizedBox(height: 8),
            Text('• Your fingerprints and face data remain private and secure'),
            SizedBox(height: 16),
            Text(
              'This provides maximum security while keeping your personal biometric information completely private.',
              style: TextStyle(
                color: AppTheme.secondaryText,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Got it'),
        ),
      ],
    );
  }
}