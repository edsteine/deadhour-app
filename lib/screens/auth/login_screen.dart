import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/utils/constants.dart';
import 'package:deadhour/services/auth_service.dart';
import 'package:deadhour/services/auth/social_provider.dart';
import 'package:deadhour/utils/error_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _rememberMe = false;
  String _loginMethod = 'email'; // 'email' or 'phone'

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              IconButton(
                onPressed: () => context.go('/onboarding'),
                icon: const Icon(Icons.arrow_back),
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
              ),
              const SizedBox(height: 24),

              // Header
              _buildHeader(),
              const SizedBox(height: 48),

              // Login method toggle
              _buildLoginMethodToggle(),
              const SizedBox(height: 24),

              // Login form
              _buildLoginForm(),
              const SizedBox(height: 24),

              // Remember me and forgot password
              _buildRememberMeAndForgotPassword(),
              const SizedBox(height: 32),

              // Login button
              _buildLoginButton(),
              const SizedBox(height: 24),

              // Divider
              _buildDivider(),
              const SizedBox(height: 24),

              // Social login options
              _buildSocialLoginOptions(),
              const SizedBox(height: 32),

              // Register option
              _buildRegisterOption(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // App logo
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text('⏰', style: TextStyle(fontSize: 24)),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DeadHour',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.moroccoGreen,
                      ),
                ),
                Text(
                  'Morocco',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.secondaryText,
                      ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 32),

        Text(
          'Welcome Back!',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryText,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Sign in to continue discovering amazing deals and connecting with the community.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.secondaryText,
              ),
        ),
      ],
    );
  }

  Widget _buildLoginMethodToggle() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildToggleButton(
              text: 'Email',
              isSelected: _loginMethod == 'email',
              onTap: () => setState(() => _loginMethod = 'email'),
            ),
          ),
          Expanded(
            child: _buildToggleButton(
              text: 'Phone',
              isSelected: _loginMethod == 'phone',
              onTap: () => setState(() => _loginMethod = 'phone'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color:
                  isSelected ? AppTheme.moroccoGreen : AppTheme.secondaryText,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email or Phone input
          TextFormField(
            controller: _emailController,
            keyboardType: _loginMethod == 'email'
                ? TextInputType.emailAddress
                : TextInputType.phone,
            decoration: InputDecoration(
              labelText:
                  _loginMethod == 'email' ? 'Email Address' : 'Phone Number',
              hintText: _loginMethod == 'email'
                  ? 'your.email@example.com'
                  : '+212 6XX XXX XXX',
              prefixIcon: Icon(
                _loginMethod == 'email'
                    ? Icons.email_outlined
                    : Icons.phone_outlined,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your ${_loginMethod == 'email' ? 'email' : 'phone number'}';
              }
              if (_loginMethod == 'email' && !value.contains('@')) {
                return 'Please enter a valid email address';
              }
              if (_loginMethod == 'phone' &&
                  !RegExp(AppConstants.phonePattern).hasMatch(value)) {
                return 'Please enter a valid Moroccan phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Password input
          TextFormField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
              prefixIcon: const Icon(Icons.lock_outlined),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < AppConstants.minPasswordLength) {
                return 'Password must be at least ${AppConstants.minPasswordLength} characters';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRememberMeAndForgotPassword() {
    return Row(
      children: [
        Row(
          children: [
            Checkbox(
              value: _rememberMe,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value ?? false;
                });
              },
              activeColor: AppTheme.moroccoGreen,
            ),
            const Text(
              'Remember me',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            // Navigate to forgot password screen
            _showForgotPasswordDialog();
          },
          child: const Text(
            'Forgot Password?',
            style: TextStyle(
              color: AppTheme.moroccoGreen,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleLogin,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade300)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'or continue with',
            style: TextStyle(
              color: AppTheme.secondaryText,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey.shade300)),
      ],
    );
  }

  Widget _buildSocialLoginOptions() {
    return Row(
      children: [
        Expanded(
          child: _buildSocialButton(
            icon: Icons.g_mobiledata,
            label: 'Google',
            onTap: () => _handleSocialLogin('google'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSocialButton(
            icon: Icons.facebook,
            label: 'Facebook',
            onTap: () => _handleSocialLogin('facebook'),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        side: BorderSide(color: Colors.grey.shade300),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterOption() {
    return Center(
      child: TextButton(
        onPressed: () => context.go('/register'),
        child: RichText(
          text: const TextSpan(
            text: 'Don\'t have an account? ',
            style: TextStyle(
              color: AppTheme.secondaryText,
              fontSize: 14,
            ),
            children: [
              TextSpan(
                text: 'Sign Up',
                style: TextStyle(
                  color: AppTheme.moroccoGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authService = AuthService();

      if (_loginMethod == 'email') {
        await authService.loginWithEmail(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          rememberMe: _rememberMe,
        );
      } else {
        await authService.loginWithPhone(
          phoneNumber: _emailController.text.trim(),
          password: _passwordController.text,
          rememberMe: _rememberMe,
        );
      }

      // Navigate to main app
      if (mounted) {
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        final appError = AppErrorHandler.parseError(e);
        AppErrorHandler.showErrorSnackbar(context, appError,
            onRetry: _handleLogin);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleSocialLogin(String provider) async {
    try {
      setState(() => _isLoading = true);

      final authService = AuthService();
      SocialProvider socialProvider;

      switch (provider.toLowerCase()) {
        case 'google':
          socialProvider = SocialProvider.google;
          break;
        case 'facebook':
          socialProvider = SocialProvider.facebook;
          break;
        default:
          throw Exception('Unsupported social provider: $provider');
      }

      await authService.loginWithSocial(
        provider: socialProvider,
        rememberMe: _rememberMe,
      );

      if (mounted) {
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        final appError = AppErrorHandler.parseError(e);
        AppErrorHandler.showErrorSnackbar(context, appError);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showForgotPasswordDialog() {
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Enter your email address and we\'ll send you a link to reset your password.',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                hintText: 'your.email@example.com',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (emailController.text.trim().isEmpty ||
                  !emailController.text.contains('@')) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter a valid email address'),
                    backgroundColor: AppColors.error,
                  ),
                );
                return;
              }

              try {
                final authService = AuthService();
                await authService.resetPassword(emailController.text.trim());

                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Password reset link sent to your email'),
                    backgroundColor: AppColors.success,
                  ),
                );
              } catch (e) {
                final appError = AppErrorHandler.parseError(e);
                AppErrorHandler.showErrorSnackbar(context, appError);
              }
            },
            child: const Text('Send Link'),
          ),
        ],
      ),
    );
  }
}
