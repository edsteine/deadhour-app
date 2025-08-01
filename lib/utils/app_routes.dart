




import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


// Import screens



























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
      GoRoute(
        path: '/web-companion',
        name: 'web-companion',
        builder: (context, state) => const WebCompanionScreen(),
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

