import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Import screens
import '../screens/auth/splash_screen.dart';
import '../screens/auth/onboarding_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/home/main_navigation_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/deals/deals_screen.dart';
import '../screens/addons/addon_marketplace_screen.dart';
import '../screens/addons/addon_switching_screen.dart';
import '../screens/community/rooms_screen.dart';
import '../screens/community/room_detail_screen.dart';
import '../screens/business/business_addon_screen.dart';
import '../screens/guide/guide_addon_screen.dart';
import '../screens/premium/premium_addon_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/profile/settings_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    routes: [
      // Authentication Routes
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/addon-marketplace',
        name: 'addon-marketplace',
        builder: (context, state) => const AddonMarketplaceScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),

      // Main App Routes with Shell Navigation
      ShellRoute(
        builder: (context, state, child) => MainNavigationScreen(child: child),
        routes: [
          // Home Tab Routes
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: 'deals',
                name: 'deals',
                builder: (context, state) => const DealsScreen(),
              ),
            ],
          ),

          // Community Tab Routes
          GoRoute(
            path: '/community',
            name: 'community',
            builder: (context, state) => const RoomsScreen(),
            routes: [
              GoRoute(
                path: 'room/:roomId',
                name: 'room-detail',
                builder: (context, state) {
                  final roomId = state.pathParameters['roomId']!;
                  return RoomDetailScreen(roomId: roomId);
                },
              ),
            ],
          ),

          // ADDON Routes
          GoRoute(
            path: '/addons',
            name: 'addons',
            builder: (context, state) => const AddonMarketplaceScreen(),
            routes: [
              GoRoute(
                path: 'switching',
                name: 'addon-switching',
                builder: (context, state) => const AddonSwitchingScreen(),
              ),
              GoRoute(
                path: 'business',
                name: 'business-addon',
                builder: (context, state) => const BusinessAddonScreen(),
              ),
              GoRoute(
                path: 'guide',
                name: 'guide-addon',
                builder: (context, state) => const GuideAddonScreen(),
              ),
              GoRoute(
                path: 'premium',
                name: 'premium-addon',
                builder: (context, state) => const PremiumAddonScreen(),
              ),
            ],
          ),

          // Profile Tab Routes
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
            routes: [
              GoRoute(
                path: 'settings',
                name: 'settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}

// Route Names for easy navigation
class AppRoutes {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String addonMarketplace = '/addon-marketplace';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String community = '/community';
  static const String roomDetail = '/community/room';
  static const String addons = '/addons';
  static const String addonSwitching = '/addons/switching';
  static const String businessAddon = '/addons/business';
  static const String guideAddon = '/addons/guide';
  static const String premiumAddon = '/addons/premium';
  static const String profile = '/profile';
  static const String settings = '/profile/settings';
}

// Navigation Helper
class AppNavigation {
  static void goToHome(BuildContext context) {
    context.go(AppRoutes.home);
  }

  static void goToLogin(BuildContext context) {
    context.go(AppRoutes.login);
  }

  static void goToRegister(BuildContext context) {
    context.go(AppRoutes.register);
  }

  static void goToAddonMarketplace(BuildContext context) {
    context.go(AppRoutes.addonMarketplace);
  }

  static void goToAddons(BuildContext context) {
    context.go(AppRoutes.addons);
  }

  static void goToCommunity(BuildContext context) {
    context.go(AppRoutes.community);
  }

  static void goToRoomDetail(BuildContext context, String roomId) {
    context.go('${AppRoutes.roomDetail}/$roomId');
  }

  static void goToBusinessAddon(BuildContext context) {
    context.go(AppRoutes.businessAddon);
  }

  static void goToGuideAddon(BuildContext context) {
    context.go(AppRoutes.guideAddon);
  }

  static void goToPremiumAddon(BuildContext context) {
    context.go(AppRoutes.premiumAddon);
  }

  static void goToAddonSwitching(BuildContext context) {
    context.go(AppRoutes.addonSwitching);
  }

  static void goToProfile(BuildContext context) {
    context.go(AppRoutes.profile);
  }

  static void goToSettings(BuildContext context) {
    context.go(AppRoutes.settings);
  }

  static void pop(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.home);
    }
  }
}

