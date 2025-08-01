import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deadhour/utils/app_theme.dart';

// TODO: Uncomment when premium features are re-enabled
// import 'package:deadhour/screens/profile/providers/role_toggle_provider.dart';
// import '../../models/user.dart';











class TourismScreen extends ConsumerStatefulWidget {
  const TourismScreen({super.key});

  @override
  ConsumerState<TourismScreen> createState() => _TourismScreenState();
}

class _TourismScreenState extends ConsumerState<TourismScreen>
    with TickerProviderStateMixin {
  // final String _selectedCity = 'Casablanca'; // TODO: Implement city selection
  late TabController _tourismTabController;

  final List<Tab> _tourismTabs = [
    const Tab(text: 'Discover'),
    const Tab(text: 'Map'),
    const Tab(text: 'Local Experts'),
    const Tab(text: 'Experiences'), 
    const Tab(text: 'Cultural'),
  ];

  // bool _isPremiumUser = false; // TODO: Uncomment when premium features are re-enabled
  final List<Map<String, String>> _experts = [
    {
      'name': 'Aisha Khan',
      'specialty': 'History & Culture',
      'image': 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=400&h=400&fit=crop&crop=face'
    },
    {
      'name': 'Omar Benali',
      'specialty': 'Food & Markets',
      'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=400&fit=crop&crop=face'
    },
    {
      'name': 'Fatima Zahra',
      'specialty': 'Art & Architecture',
      'image': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400&h=400&fit=crop&crop=face'
    },
    {
      'name': 'Youssef El Fassi',
      'specialty': 'Outdoor Adventures',
      'image': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400&h=400&fit=crop&crop=face'
    },
  ];

  @override
  void initState() {
    super.initState();
    _tourismTabController = TabController(length: _tourismTabs.length, vsync: this);
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
    _tourismTabController.dispose();
    super.dispose();
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
              backgroundImage: NetworkImage(expert['image']!),
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


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tourism welcome banner for tourist-friendly experience
        const TourismWelcomeBanner(),
        
        // Tourism tabs (like GetYourGuide/Viator structure)
        TabBar(
          controller: _tourismTabController,
          labelColor: AppTheme.moroccoGreen,
          unselectedLabelColor: AppTheme.secondaryText,
          indicatorColor: AppTheme.moroccoGreen,
          tabs: _tourismTabs,
        ),

        // Tourism tab content
        Expanded(
          child: TabBarView(
            controller: _tourismTabController,
            children: [
              // Discover tab - Comprehensive tourism discovery with rich features
              DiscoverTab(
                buildSectionHeader: _buildSectionHeader,
                buildQuickDiscoveryGrid: () => const QuickDiscoveryGrid(),
                buildTrendingExperiences: () => const TrendingExperiences(),
              ),
              
              // Map tab - Visual map interface for venue and deal discovery
              MapViewWidget(
                selectedCategory: 'tourism',
                onDealTap: (deal) {
                  // Handle deal tap from map
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected deal: ${deal.title}')),
                  );
                },
              ),
              
              // Local Experts tab - List of advisors/guides
              LocalExpertsTab(
                buildSectionHeader: _buildSectionHeader,
                buildExpertCard: (expert) => _buildExpertCard(expert),
                experts: _experts,
              ),
              // Experiences tab - Authentic activities
              TourismExperiencesTab(
                buildSectionHeader: _buildSectionHeader,
                buildExperienceCard: _buildExperienceCard,
              ),
              // Cultural tab - Cultural sites, events, tips
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
