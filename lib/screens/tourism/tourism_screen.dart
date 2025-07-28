import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/theme.dart';
import '../../utils/error_handler.dart';
import '../../utils/performance_utils.dart';
// TODO: Uncomment when premium features are re-enabled
// import '../../providers/role_toggle_provider.dart';
// import '../../models/user.dart';
import 'package:deadhour/screens/tourism/widgets/tourism_welcome_banner.dart';
import 'package:deadhour/screens/tourism/widgets/discover_tab.dart';
import 'package:deadhour/screens/tourism/widgets/local_experts_tab.dart';
import 'package:deadhour/screens/tourism/widgets/experiences_tab.dart';
import 'package:deadhour/screens/tourism/widgets/cultural_tab.dart';
import 'package:deadhour/screens/tourism/utils/tourism_action_helpers.dart';
import 'package:deadhour/screens/tourism/widgets/quick_discovery_grid.dart';
import 'package:deadhour/screens/tourism/widgets/trending_experiences.dart';
import 'package:deadhour/screens/tourism/widgets/tourist_friendly_deals.dart';
import 'package:deadhour/screens/tourism/widgets/social_discovery_button.dart';
import 'package:deadhour/screens/tourism/widgets/cultural_dashboard.dart';
import 'package:deadhour/screens/tourism/widgets/cultural_events.dart';
import 'package:deadhour/screens/tourism/widgets/cultural_tips.dart';

class TourismScreen extends ConsumerStatefulWidget {
  const TourismScreen({super.key});

  @override
  ConsumerState<TourismScreen> createState() => _TourismScreenState();
}

class _TourismScreenState extends ConsumerState<TourismScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  // final String _selectedCity = 'Casablanca'; // TODO: Implement city selection

  final List<Tab> _tabs = [
    const Tab(text: 'Discover'),
    const Tab(text: 'Local Experts'),
    const Tab(text: 'Experiences'),
    const Tab(text: 'Cultural'),
  ];

  // bool _isPremiumUser = false; // TODO: Uncomment when premium features are re-enabled
  final List<Map<String, String>> _experts = [
    {
      'name': 'Aisha Khan',
      'specialty': 'History & Culture',
      'image': 'assets/images/aisha.jpg'
    },
    {
      'name': 'Omar Benali',
      'specialty': 'Food & Markets',
      'image': 'assets/images/omar.jpg'
    },
    {
      'name': 'Fatima Zahra',
      'specialty': 'Art & Architecture',
      'image': 'assets/images/fatima.jpg'
    },
    {
      'name': 'Youssef El Fassi',
      'specialty': 'Outdoor Adventures',
      'image': 'assets/images/youssef.jpg'
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    // _isPremiumUser = ref.read(roleToggleProvider) == UserRole.premium; // TODO: Uncomment when premium features are re-enabled
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppTheme.darkBlue,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildPremiumUpgradeCard() {
    return Card(
      margin: const EdgeInsets.all(16.0),
      color: AppTheme.accentColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Unlock Premium Features',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.nearlyWhite,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Upgrade to premium to access exclusive expert content and personalized recommendations.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.nearlyWhite.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => TourismActionHelpers.showPremiumUpgrade(context,
                  (value) => setState(() => {} /* _isPremiumUser = value */)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.moroccoGreen,
                foregroundColor: AppTheme.nearlyWhite,
              ),
              child: const Text('Upgrade Now'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceCard(Map<String, String> experience) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              experience['title']!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkBlue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              experience['description']!,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.secondaryText,
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                experience['price']!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.moroccoGreen,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpertCard(Map<String, String> expert) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(expert['image']!),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expert['name']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkBlue,
                  ),
                ),
                Text(
                  expert['specialty']!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.secondaryText,
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                // Handle expert profile navigation
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTourismWelcomeBanner() {
    return const TourismWelcomeBanner();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tourism welcome banner
        ErrorHandler.safeBuild(
          () => _buildTourismWelcomeBanner(),
          errorMessage: 'Unable to load welcome banner',
        ),

        // Tab bar
        TabBar(
          controller: _tabController,
          labelColor: AppTheme.moroccoGreen,
          unselectedLabelColor: AppTheme.secondaryText,
          indicatorColor: AppTheme.moroccoGreen,
          tabs: _tabs,
          physics: const OptimizedScrollPhysics(),
        ),

        // Tab views
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: const OptimizedScrollPhysics(),
            children: [
              DiscoverTab(
                buildSectionHeader: _buildSectionHeader,
                buildQuickDiscoveryGrid: () => const QuickDiscoveryGrid(),
                buildTrendingExperiences: () => const TrendingExperiences(),
                buildSocialDiscoveryButton: () => const SocialDiscoveryButton(),
                buildTouristFriendlyDeals: () => const TouristFriendlyDeals(),
              ),
              LocalExpertsTab(
                buildSectionHeader: _buildSectionHeader,
                buildPremiumUpgradeCard: _buildPremiumUpgradeCard,
                buildExpertCard: (expert) => _buildExpertCard(expert),
                experts: _experts,
              ),
              ExperiencesTab(
                buildSectionHeader: _buildSectionHeader,
                buildExperienceCard: _buildExperienceCard,
              ),
              CulturalTab(
                buildCulturalDashboard: () => const CulturalDashboard(),
                buildSectionHeader: _buildSectionHeader,
                buildCulturalEvents: () => const CulturalEvents(),
                buildCulturalTips: () => const CulturalTips(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // TODO: Implement menu and expert request features
  /*
  void _handleMenuPress() {
    PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
    TourismActionHelpers.showTourismMenu(
      context, 
      () => TourismActionHelpers.showPremiumUpgrade(
        context, 
        (value) => setState(() => _isPremiumUser = value)
      )
    );
  }

  void _handleExpertRequest() {
    PerformanceUtils.hapticFeedback(HapticFeedbackType.medium);
    TourismActionHelpers.showExpertRequest(
      context, 
      ref, 
      _isPremiumUser, 
      () => TourismActionHelpers.showPremiumUpgrade(
        context, 
        (value) => setState(() => _isPremiumUser = value)
      )
    );
  }
  */
}
