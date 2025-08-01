import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:deadhour/utils/app_theme.dart';
import 'package:deadhour/utils/constants.dart';

import 'package:deadhour/utils/app_error_handler.dart';
import 'package:deadhour/utils/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _businessNameController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  bool _acceptTerms = false;

  String _selectedUserType = 'local';
  String _selectedCity = 'Casablanca';
  String _selectedLanguage = 'en';
  String? _selectedBusinessCategory;

  @override
  void initState() {
    super.initState();
    // Get user type from route parameters if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final uri = GoRouterState.of(context).uri;
      final userType = uri.queryParameters['userType'];
      if (userType != null) {
        setState(() {
          _selectedUserType = userType;
        });
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _businessNameController.dispose();
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
              const SizedBox(height: 32),

              // User type selection (if not already selected)
              if (_selectedUserType.isEmpty) ...[
                _buildUserTypeSelection(),
                const SizedBox(height: 24),
              ],

              // Registration form
              _buildRegistrationForm(),
              const SizedBox(height: 24),

              // Terms and conditions
              _buildTermsAndConditions(),
              const SizedBox(height: 32),

              // Register button
              _buildRegisterButton(),
              const SizedBox(height: 24),

              // Login option
              _buildLoginOption(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final userType = AppConstants.userTypes.firstWhere(
      (type) => type['id'] == _selectedUserType,
      orElse: () => AppConstants.userTypes.first,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Selected user type indicator
        if (_selectedUserType.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(userType['icon']!, style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                Text(
                  userType['name']!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.moroccoGreen,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 16),

        Text(
          'Create Your Account',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryText,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Join Morocco\'s first social venue discovery platform and start saving while discovering amazing experiences.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.secondaryText,
              ),
        ),
      ],
    );
  }

  Widget _buildUserTypeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account Type',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: AppConstants.userTypes.map((userType) {
              final isSelected = _selectedUserType == userType['id'];
              return DecoratedBox(
                decoration: isSelected
                    ? BoxDecoration(
                        color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      )
                    : null,
                child: ListTile(
                  leading: Text(userType['icon']!,
                      style: const TextStyle(fontSize: 20)),
                  title: Text(userType['name']!),
                  subtitle: Text(userType['description']!),
                  trailing: Radio<String>(
                    value: userType['id']!,
                    groupValue: _selectedUserType,
                    onChanged: (value) {
                      setState(() {
                        _selectedUserType = value!;
                      });
                    },
                    activeColor: AppTheme.moroccoGreen,
                  ),
                  onTap: () {
                    setState(() {
                      _selectedUserType = userType['id']!;
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRegistrationForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Full Name
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Full Name',
              hintText: 'Enter your full name',
              prefixIcon: Icon(Icons.person_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Email
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email Address',
              hintText: 'your.email@example.com',
              prefixIcon: Icon(Icons.email_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email address';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Phone Number
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              hintText: '+212 6XX XXX XXX',
              prefixIcon: Icon(Icons.phone_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              if (!RegExp(AppConstants.phonePattern).hasMatch(value)) {
                return 'Please enter a valid Moroccan phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // City Selection
          DropdownButtonFormField<String>(
            value: _selectedCity,
            decoration: const InputDecoration(
              labelText: 'City',
              prefixIcon: Icon(Icons.location_city_outlined),
            ),
            items: AppConstants.moroccoCities.map((city) {
              return DropdownMenuItem(
                value: city,
                child: Text(city),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCity = value!;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your city';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Language Selection
          DropdownButtonFormField<String>(
            value: _selectedLanguage,
            decoration: const InputDecoration(
              labelText: 'Preferred Language',
              prefixIcon: Icon(Icons.language_outlined),
            ),
            items: AppConstants.supportedLanguages.map((language) {
              return DropdownMenuItem(
                value: language['code'],
                child: Text('${language['name']} (${language['englishName']})'),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value!;
              });
            },
          ),
          const SizedBox(height: 16),

          // Business-specific fields
          if (_selectedUserType == 'business') ...[
            TextFormField(
              controller: _businessNameController,
              decoration: const InputDecoration(
                labelText: 'Business Name',
                hintText: 'Enter your business name',
                prefixIcon: Icon(Icons.business_outlined),
              ),
              validator: (value) {
                if (_selectedUserType == 'business' &&
                    (value == null || value.isEmpty)) {
                  return 'Please enter your business name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedBusinessCategory,
              decoration: const InputDecoration(
                labelText: 'Business Category',
                prefixIcon: Icon(Icons.category_outlined),
              ),
              items: AppConstants.businessCategories.map((category) {
                return DropdownMenuItem(
                  value: category['id'] as String,
                  child: Row(
                    children: [
                      Text(category['icon'] as String,
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(width: 8),
                      Text(category['name'] as String),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedBusinessCategory = value;
                });
              },
              validator: (value) {
                if (_selectedUserType == 'business' && value == null) {
                  return 'Please select your business category';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
          ],

          // Password
          TextFormField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Create a strong password',
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
                return 'Please enter a password';
              }
              if (value.length < AppConstants.minPasswordLength) {
                return 'Password must be at least ${AppConstants.minPasswordLength} characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Confirm Password
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: !_isConfirmPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              hintText: 'Re-enter your password',
              prefixIcon: const Icon(Icons.lock_outlined),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
                icon: Icon(
                  _isConfirmPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: _acceptTerms,
          onChanged: (value) {
            setState(() {
              _acceptTerms = value ?? false;
            });
          },
          activeColor: AppTheme.moroccoGreen,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _acceptTerms = !_acceptTerms;
              });
            },
            child: RichText(
              text: const TextSpan(
                text: 'I agree to the ',
                style: TextStyle(
                  color: AppTheme.secondaryText,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(
                      color: AppTheme.moroccoGreen,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      color: AppTheme.moroccoGreen,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (_acceptTerms && !_isLoading) ? _handleRegister : null,
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
                'Create Account',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Widget _buildLoginOption() {
    return Center(
      child: TextButton(
        onPressed: () => context.go('/login'),
        child: RichText(
          text: const TextSpan(
            text: 'Already have an account? ',
            style: TextStyle(
              color: AppTheme.secondaryText,
              fontSize: 14,
            ),
            children: [
              TextSpan(
                text: 'Sign In',
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

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authService = AuthService();

      await authService.register(
        fullName: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        password: _passwordController.text,
        city: _selectedCity,
        language: _selectedLanguage,
        userType: _selectedUserType,
        businessName: _selectedUserType == 'business'
            ? _businessNameController.text.trim()
            : null,
        businessCategory:
            _selectedUserType == 'business' ? _selectedBusinessCategory : null,
      );

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Account created successfully! Please verify your email.'),
            backgroundColor: AppColors.success,
          ),
        );

        // Navigate to main app
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        final appError = AppErrorHandler.parseError(e);
        AppErrorHandler.showErrorSnackbar(context, appError,
            onRetry: _handleRegister);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
