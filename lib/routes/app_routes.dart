import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Import screens
import 'package:deadhour/screens/auth/splash_screen.dart';
import 'package:deadhour/screens/auth/onboarding_screen.dart';
import 'package:deadhour/screens/auth/login_screen.dart';
import 'package:deadhour/screens/auth/register_screen.dart';
import 'package:deadhour/screens/auth/role_marketplace_screen.dart';
import 'package:deadhour/screens/home/main_navigation_screen.dart';
import 'package:deadhour/screens/community/room_detail_screen.dart';
import 'package:deadhour/screens/community/room_chat_screen.dart';
import 'package:deadhour/screens/business/business_dashboard_screen.dart';
import 'package:deadhour/screens/business/create_deal_screen.dart';
import 'package:deadhour/screens/business/revenue_optimization_screen.dart';
import 'package:deadhour/screens/business/analytics_dashboard_screen.dart';
import 'package:deadhour/screens/guide/guide_role_screen.dart';
import 'package:deadhour/screens/tourism/local_expert_screen.dart';
import 'package:deadhour/screens/social/social_discovery_screen.dart';
import 'package:deadhour/screens/profile/settings_screen.dart';
import 'package:deadhour/screens/home/booking_flow_screen.dart';
import 'package:deadhour/screens/admin/network_effects_dashboard_screen.dart';
import 'package:deadhour/screens/venues/venue_detail_screen.dart';
import 'package:deadhour/screens/social/group_booking_screen.dart';
import 'package:deadhour/screens/settings/accessibility_settings_screen.dart';
import 'package:deadhour/screens/settings/offline_settings_screen.dart';
import 'package:deadhour/screens/home/tourist_home_screen.dart';
import 'package:deadhour/screens/role_switching_screen/role_switching_screen.dart';
import 'package:deadhour/screens/profile/premium_role_screen.dart';
import 'package:deadhour/screens/admin/community_health_dashboard_screen.dart';
import 'package:deadhour/screens/payment/payment_screen.dart';
import 'package:deadhour/screens/cultural/cultural_ambassador_application_screen.dart';
import 'package:deadhour/models/deal.dart';

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
        builder: (context, state) => const RoleMarketplaceScreen(),
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

      // Main App Routes with Tab Navigation  
      GoRoute(
        path: '/home',
        name: 'home',
        redirect: (context, state) => '/deals', // Redirect to deals tab
      ),
      GoRoute(
        path: '/deals',
        name: 'deals',
        builder: (context, state) => const MainNavigationScreen(),
      ),
      GoRoute(
        path: '/venues',
        name: 'venues',
        builder: (context, state) => const MainNavigationScreen(),
      ),
      GoRoute(
        path: '/community',
        name: 'community',
        builder: (context, state) => const MainNavigationScreen(),
      ),
      GoRoute(
        path: '/tourism',
        name: 'tourism',
        builder: (context, state) => const MainNavigationScreen(),
      ),
      GoRoute(
        path: '/notifications',
        name: 'notifications',
        builder: (context, state) => const MainNavigationScreen(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const MainNavigationScreen(),
      ),
      GoRoute(
        path: '/venue-detail/:venueId',
        name: 'venue-detail',
        builder: (context, state) {
          final venueId = state.pathParameters['venueId']!;
          return VenueDetailScreen(venueId: venueId);
        },
      ),
      GoRoute(
        path: '/booking',
        name: 'booking-flow',
        builder: (context, state) {
          final deal = state.extra as Deal;
          return BookingFlowScreen(deal: deal);
        },
      ),

      // Community sub-routes
      GoRoute(
        path: '/room/:roomId',
        name: 'room-detail',
        builder: (context, state) {
          final roomId = state.pathParameters['roomId']!;
          return RoomDetailScreen(roomId: roomId);
        },
      ),
      GoRoute(
        path: '/room/:roomId/chat',
        name: 'room-chat',
        builder: (context, state) {
          final roomId = state.pathParameters['roomId']!;
          return RoomChatScreen(roomId: roomId);
        },
      ),

      // Business Routes - Revenue Optimization
      GoRoute(
        path: '/business',
        name: 'business',
        builder: (context, state) => const BusinessDashboardScreen(),
      ),
      GoRoute(
        path: '/business/create-deal',
        name: 'create-deal',
        builder: (context, state) => const CreateDealScreen(),
      ),
      GoRoute(
        path: '/business/optimization',
        name: 'revenue-optimization',
        builder: (context, state) => const RevenueOptimizationScreen(),
      ),
      GoRoute(
        path: '/business/analytics',
        name: 'business-analytics',
        builder: (context, state) => const AnalyticsDashboardScreen(),
      ),

      // Tourism sub-routes
      GoRoute(
        path: '/local-expert',
        name: 'local-expert',
        builder: (context, state) => const LocalExpertScreen(),
      ),
      GoRoute(
        path: '/social-discovery',
        name: 'social-discovery',
        builder: (context, state) => const SocialDiscoveryScreen(),
      ),

      // Guide Routes
      GoRoute(
        path: '/guide',
        name: 'guide',
        builder: (context, state) => const GuideRoleScreen(),
      ),

      // Settings
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),


      // Group Booking
      GoRoute(
        path: '/group-booking',
        name: 'group-booking',
        builder: (context, state) => const GroupBookingScreen(),
      ),

      // Settings sub-routes
      GoRoute(
        path: '/settings/accessibility',
        name: 'accessibility-settings',
        builder: (context, state) => const AccessibilitySettingsScreen(),
      ),
      GoRoute(
        path: '/settings/offline',
        name: 'offline-settings',
        builder: (context, state) => const OfflineSettingsScreen(),
      ),

      // MVP completion routes
      GoRoute(
        path: '/tourist-home',
        name: 'tourist-home',
        builder: (context, state) => const TouristHomeScreen(),
      ),
      GoRoute(
        path: '/roles/switching',
        name: 'role-switching',
        builder: (context, state) => const RoleSwitchingScreen(),
      ),
      GoRoute(
        path: '/roles/premium',
        name: 'premium-role',
        builder: (context, state) => const PremiumRoleScreen(),
      ),

      // Admin Routes
      GoRoute(
        path: '/admin',
        name: 'admin',
        builder: (context, state) => const NetworkEffectsDashboardScreen(),
      ),
      GoRoute(
        path: '/admin/community-health',
        name: 'community-health',
        builder: (context, state) => const CommunityHealthDashboardScreen(),
      ),

      // Payment Route (for testing - uses mock data)
      GoRoute(
        path: '/payment',
        name: 'payment',
        builder: (context, state) {
          // Use mock data for dev menu testing
          final mockDeal = Deal(
            id: 'mock-deal-1',
            venueId: 'mock-venue-1',
            title: 'Mock Deal for Testing',
            description: 'Test payment flow with mock data',
            discountType: 'percentage',
            discountValue: 30.0,
            originalPrice: 100.0,
            discountedPrice: 70.0,
            validFrom: DateTime.now(),
            validUntil: DateTime.now().add(const Duration(hours: 6)),
            maxCapacity: 20,
            currentBookings: 5,
            categories: ['food', 'test'],
            daysOfWeek: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
            timeSlots: ['18:00-20:00', '20:00-22:00'],
            imageUrl: 'https://via.placeholder.com/400x200',
            isPrayerTimeAware: true,
            isHalalOnly: true,
          );
          
          final mockBookingDetails = {
            'participants': 2,
            'selectedTime': '19:00',
            'selectedDate': DateTime.now().add(const Duration(days: 1)),
            'totalAmount': 140.0,
            'customerName': 'Test Customer',
            'customerPhone': '+212 6 12 34 56 78',
          };

          return PaymentScreen(
            deal: mockDeal,
            bookingDetails: mockBookingDetails,
          );
        },
      ),

      // Cultural Ambassador Application (Future Feature)
      GoRoute(
        path: '/cultural-ambassador-application',
        name: 'cultural-ambassador-application',
        builder: (context, state) => const CulturalAmbassadorApplicationScreen(),
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
  static const String userType = '/user-type';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String deals = '/deals';
  static const String venues = '/venues';
  static const String venueDetail = '/venue-detail';
  static const String bookingFlow = '/booking';
  static const String community = '/community';
  static const String roomDetail = '/room';
  static const String roomChat = '/room/*/chat';
  static const String business = '/business';
  static const String createDeal = '/business/create-deal';
  static const String revenueOptimization = '/business/optimization';
  static const String businessAnalytics = '/business/analytics';
  static const String tourism = '/tourism';
  static const String localExpert = '/local-expert';
  static const String socialDiscovery = '/social-discovery';
  static const String guide = '/guide';
  static const String admin = '/admin';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String accessibilitySettings = '/settings/accessibility';
  static const String offlineSettings = '/settings/offline';
  static const String touristHome = '/tourist-home';
  static const String roleSwitching = '/roles/switching';
  static const String premiumRole = '/roles/premium';
  static const String communityHealth = '/admin/community-health';
  static const String notifications = '/notifications';
  static const String groupBooking = '/group-booking';
  static const String payment = '/payment';
  static const String culturalAmbassadorApplication = '/cultural-ambassador-application';
}

// Navigation Helper
class AppNavigation {
  static void goToHome(BuildContext context) {
    context.go(AppRoutes.home);
  }

  static void goToDeals(BuildContext context) {
    context.go(AppRoutes.deals);
  }

  static void goToVenues(BuildContext context) {
    context.go(AppRoutes.venues);
  }

  static void goToVenueDetail(BuildContext context, String venueId) {
    context.go('${AppRoutes.venueDetail}/$venueId');
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

  static void goToGuide(BuildContext context) {
    context.go(AppRoutes.guide);
  }

  static void goToProfile(BuildContext context) {
    context.go(AppRoutes.profile);
  }

  static void goToSettings(BuildContext context) {
    context.go(AppRoutes.settings);
  }

  static void goToNotifications(BuildContext context) {
    context.go(AppRoutes.notifications);
  }

  static void goToGroupBooking(BuildContext context) {
    context.go(AppRoutes.groupBooking);
  }

  static void goToAccessibilitySettings(BuildContext context) {
    context.push(AppRoutes.accessibilitySettings);
  }

  static void goToOfflineSettings(BuildContext context) {
    context.push(AppRoutes.offlineSettings);
  }

  static void goToBookingFlow(BuildContext context, Deal deal) {
    context.push(AppRoutes.bookingFlow, extra: deal);
  }

  static void goToAdmin(BuildContext context) {
    context.go(AppRoutes.admin);
  }

  static void pop(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.home);
    }
  }
}
