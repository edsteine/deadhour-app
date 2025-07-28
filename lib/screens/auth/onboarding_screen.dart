import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';
import '../../utils/guest_mode.dart';
import '../../services/onboarding_service.dart';
import '../../widgets/common/loading_widgets.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isLoading = false;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Welcome to DeadHour',
      subtitle: 'Morocco\'s Smart Discovery Platform',
      description:
          'Turn empty restaurant hours into your best deals. Where businesses solve revenue problems and you discover authentic experiences — completely free.',
      icon: '🇲🇦',
      gradient: const [AppTheme.moroccoGreen, AppTheme.darkGreen],
    ),
    OnboardingPage(
      title: 'Problem 1: Empty Venues',
      subtitle: '3 PM at restaurants = Empty chairs = Lost money',
      description:
          'Every day, Morocco\'s 300,000+ venues have "dead hours" with empty seats. That\'s money walking out the door. We turn those empty hours into your opportunity.',
      icon: '🪑',
      gradient: const [AppColors.foodCategory, Color(0xFFD35400)],
    ),
    OnboardingPage(
      title: 'Problem 2: Where to Go?',
      subtitle: 'Tourists + Locals = Same question: "What\'s good?"',
      description:
          'Morocco welcomes 13M+ tourists yearly, plus 8M+ locals in cities. Everyone asks the same question: where should I go? Community rooms have the answers.',
      icon: '🤔',
      gradient: const [AppColors.tourismCategory, Color(0xFFC2185B)],
    ),
    OnboardingPage(
      title: 'Our Solution: Two Birds, One Stone',
      subtitle: 'Business deals become social content',
      description:
          'Empty venue hours = Great deals for you. Your questions = Traffic for venues. Join community rooms where deals get discussed, validated, and shared.',
      icon: '🎯',
      gradient: const [AppColors.entertainmentCategory, Color(0xFF2980B9)],
    ),
    OnboardingPage(
      title: 'Real Community, Real Results',
      subtitle: 'Where everyone wins together',
      description:
          '🏪 Businesses fill dead hours\n👥 You discover authentic experiences\n🌍 Tourists find local favorites\n🇲🇦 Morocco shows its best side',
      icon: '🤝',
      gradient: const [AppColors.wellnessCategory, Color(0xFF16A085)],
    ),
    OnboardingPage(
      title: 'Ready to Start?',
      subtitle: 'Join Morocco\'s smartest discovery community',
      description:
          'Explore deals and experiences immediately. No payment required, no premium features locked away — everything is completely free.',
      icon: '🚀',
      gradient: const [AppTheme.moroccoGreen, AppTheme.darkGreen],
      isActionPage: true,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? LoadingWidgets.buildHomeScreenSkeleton()
          : Stack(
              children: [
                // Background gradient
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: _pages[_currentPage].gradient,
                    ),
                  ),
                ),

                // Content
                SafeArea(
                  child: Column(
                    children: [
                      // Skip button
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: _handleSkip,
                          child: const Text(
                            'Skip',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      // Page view
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          itemCount: _pages.length,
                          itemBuilder: (context, index) {
                            return _buildPage(_pages[index]);
                          },
                        ),
                      ),

                      // Page indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _pages.asMap().entries.map((entry) {
                          return Container(
                            width: _currentPage == entry.key ? 24 : 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: _currentPage == entry.key
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.4),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 32),

                      // Navigation buttons
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            if (_currentPage > 0)
                              TextButton(
                                onPressed: () {
                                  _pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: const Text(
                                  'Previous',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () async {
                                if (_currentPage == _pages.length - 1) {
                                  await GuestMode.markOnboardingCompleted();
                                  await GuestMode.enableGuestMode();
                                  if (context.mounted) context.go('/home');
                                } else {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor:
                                    _pages[_currentPage].gradient[0],
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Text(
                                _currentPage == _pages.length - 1
                                    ? 'Get Started'
                                    : 'Next',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(60),
            ),
            child: Center(
              child: Text(
                page.icon,
                style: const TextStyle(fontSize: 60),
              ),
            ),
          ),
          const SizedBox(height: 48),

          // Title
          Text(
            page.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Subtitle
          Text(
            page.subtitle,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // Description
          Text(
            page.description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withValues(alpha: 0.8),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),

          // Action buttons for the final page
          if (page.isActionPage) _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      child: Column(
        children: [
          // Guest mode option
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _handleGuestMode,
              icon: const Icon(Icons.visibility),
              label: const Text('Explore as Guest'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: Colors.white),
                foregroundColor: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Sign up option
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _handleSignUp,
              icon: const Icon(Icons.person_add),
              label: const Text('Create Account'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.white,
                foregroundColor: AppTheme.moroccoGreen,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Login option
          TextButton(
            onPressed: _handleLogin,
            child: Text(
              'Already have an account? Log in',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.8)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSkip() async {
    setState(() => _isLoading = true);

    try {
      await OnboardingService().skipOnboarding();
      if (mounted) {
        context.go('/home');
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleGuestMode() async {
    setState(() => _isLoading = true);

    try {
      await OnboardingService().startGuestExperience();
      await OnboardingService().completeOnboarding();

      if (mounted) {
        context.go('/home');
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error starting guest mode: ${error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleSignUp() async {
    await OnboardingService().completeOnboarding();
    if (mounted) {
      context.go('/register');
    }
  }

  Future<void> _handleLogin() async {
    await OnboardingService().completeOnboarding();
    if (mounted) {
      context.go('/login');
    }
  }
}

class OnboardingPage {
  final String title;
  final String subtitle;
  final String description;
  final String icon;
  final List<Color> gradient;
  final bool isActionPage;

  OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.gradient,
    this.isActionPage = false,
  });
}
