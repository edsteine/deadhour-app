import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Import screens
import '../screens/auth/splash_screen.dart';
import '../screens/auth/onboarding_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/role_marketplace_screen.dart';
import '../screens/home/main_navigation_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/home/deals_screen.dart';
import '../screens/home/venue_discovery_screen.dart';
import '../screens/community/rooms_screen.dart';
import '../screens/community/room_detail_screen.dart';
import '../screens/community/room_chat_screen.dart';
import '../screens/business/business_dashboard_screen.dart';
import '../screens/business/create_deal_screen.dart';
import '../screens/business/revenue_optimization_screen.dart';
import '../screens/business/analytics_dashboard_screen.dart';
import '../screens/guide/guide_addon_screen.dart';
import '../screens/tourism/tourism_screen.dart';
import '../screens/tourism/local_expert_screen.dart';
import '../screens/social/social_discovery_screen.dart';
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
        path: '/user-type',
        name: 'user-type',
        builder: (context, state) => RoleMarketplaceScreen(),
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
              GoRoute(
                path: 'venues',
                name: 'venues',
                builder: (context, state) => const VenueDiscoveryScreen(),
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
                routes: [
                  GoRoute(
                    path: 'chat',
                    name: 'room-chat',
                    builder: (context, state) {
                      final roomId = state.pathParameters['roomId']!;
                      return RoomChatScreen(roomId: roomId);
                    },
                  ),
                ],
              ),
            ],
          ),

          // Business Routes - Revenue Optimization
          GoRoute(
            path: '/business',
            name: 'business',
            builder: (context, state) => const BusinessDashboardScreen(),
            routes: [
              GoRoute(
                path: 'create-deal',
                name: 'create-deal',
                builder: (context, state) => const CreateDealScreen(),
              ),
              GoRoute(
                path: 'optimization',
                name: 'revenue-optimization',
                builder: (context, state) => const RevenueOptimizationScreen(),
              ),
              GoRoute(
                path: 'analytics',
                name: 'business-analytics',
                builder: (context, state) => const AnalyticsDashboardScreen(),
              ),
            ],
          ),

          // Tourism Routes - Social Discovery
          GoRoute(
            path: '/tourism',
            name: 'tourism',
            builder: (context, state) => const TourismScreen(),
            routes: [
              GoRoute(
                path: 'local-expert',
                name: 'local-expert',
                builder: (context, state) => const LocalExpertScreen(),
              ),
              GoRoute(
                path: 'social-discovery',
                name: 'social-discovery',
                builder: (context, state) => const SocialDiscoveryScreen(),
              ),
            ],
          ),

          // Role Routes
          GoRoute(
            path: '/roles',
            name: 'roles',
            builder: (context, state) => const Scaffold(body: Center(child: Text('Role Marketplace - Coming Soon'))),
            routes: [
              GoRoute(
                path: 'switching',
                name: 'role-switching',
                builder: (context, state) => const Scaffold(body: Center(child: Text('Role Switching - Coming Soon'))),
              ),
              GoRoute(
                path: 'guide',
                name: 'guide-role',
                builder: (context, state) => const GuideAddonScreen(),
              ),
              GoRoute(
                path: 'premium',
                name: 'premium-role',
                builder: (context, state) => const Scaffold(body: Center(child: Text('Premium Role - Coming Soon'))),
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
  static const String rolesSelection = '/roles_selection';
  static const String userType = '/user-type';
  
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String deals = '/home/deals';
  static const String venues = '/home/venues';
  static const String community = '/community';
  static const String roomDetail = '/community/room';
  static const String roomChat = '/community/room/*/chat';
  static const String business = '/business';
  static const String createDeal = '/business/create-deal';
  static const String revenueOptimization = '/business/optimization';
  static const String businessAnalytics = '/business/analytics';
  static const String tourism = '/tourism';
  static const String localExpert = '/tourism/local-expert';
  static const String socialDiscovery = '/tourism/social-discovery';
  static const String premiumRole = '/roles/premium';
  
  
  static const String profile = '/profile';
  static const String settings = '/profile/settings';
}

// Navigation Helper
class AppNavigation {
  static void goToHome(BuildContext context) {
    context.go(AppRoutes.home);
  }

  static void goToVenues(BuildContext context) {
    context.go(AppRoutes.venues);
  }

  static void goToLogin(BuildContext context) {
    context.go(AppRoutes.login);
  }

  static void goToRegister(BuildContext context) {
    context.go(AppRoutes.register);
  }

  static void goToUserType(BuildContext context) {
    context.go(AppRoutes.userType);
  }

  

  

  static void goToCommunity(BuildContext context) {
    context.go(AppRoutes.community);
  }

  static void goToRoomDetail(BuildContext context, String roomId) {
    context.go('${AppRoutes.roomDetail}/$roomId');
  }

  static void goToBusiness(BuildContext context) {
    context.go(AppRoutes.business);
  }

  static void goToCreateDeal(BuildContext context) {
    context.go(AppRoutes.createDeal);
  }

  static void goToRevenueOptimization(BuildContext context) {
    context.go(AppRoutes.revenueOptimization);
  }

  static void goToBusinessAnalytics(BuildContext context) {
    context.go(AppRoutes.businessAnalytics);
  }

  static void goToTourism(BuildContext context) {
    context.go(AppRoutes.tourism);
  }

  static void goToLocalExpert(BuildContext context) {
    context.go(AppRoutes.localExpert);
  }

  static void goToSocialDiscovery(BuildContext context) {
    context.go(AppRoutes.socialDiscovery);
  }

  

  static void goToPremiumRole(BuildContext context) {
    context.go(AppRoutes.premiumRole);
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

