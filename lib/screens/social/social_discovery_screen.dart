import '../dev_menu/enhanced_app_bar.dart';
import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import 'widgets/social_filters_and_search.dart';
import 'widgets/social_tab_bar.dart';
import 'widgets/social_action_helpers.dart';
import 'widgets/experiences_tab.dart';
import 'widgets/my_connections_tab.dart';
import 'widgets/create_experience_tab.dart';

class SocialDiscoveryScreen extends StatefulWidget {
  const SocialDiscoveryScreen({super.key});

  @override
  State<SocialDiscoveryScreen> createState() => _SocialDiscoveryScreenState();
}

class _SocialDiscoveryScreenState extends State<SocialDiscoveryScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedInterest = 'all';

  final List<Map<String, dynamic>> _socialInterests = [
    {'id': 'all', 'name': 'All Interests', 'icon': '🌟'},
    {'id': 'foodie', 'name': 'Foodie Adventures', 'icon': '🍽️'},
    {'id': 'culture', 'name': 'Cultural Explorer', 'icon': '🎭'},
    {'id': 'nightlife', 'name': 'Nightlife', 'icon': '🌙'},
    {'id': 'wellness', 'name': 'Wellness Journey', 'icon': '🧘'},
    {'id': 'adventure', 'name': 'Adventure Seeker', 'icon': '🏔️'},
    {'id': 'local', 'name': 'Local Secrets', 'icon': '🗝️'},
  ];

  final List<Map<String, dynamic>> _mockSocialExperiences = [
    {
      'id': '1',
      'title': 'Hidden Gems Food Tour',
      'category': 'foodie',
      'description': 'Discover authentic street food spots locals love',
      'host': {
        'name': 'Youssef Local',
        'avatar': 'https://via.placeholder.com/50',
        'rating': 4.9,
        'isVerified': true,
      },
      'participants': 8,
      'maxParticipants': 12,
      'price': 180,
      'location': 'Marrakech Medina',
      'dateTime': 'Today 18:00',
      'duration': '3 hours',
      'tags': ['authentic', 'local-guide', 'small-group'],
      'images': ['https://via.placeholder.com/300x200'],
      'venue': 'Multiple locations',
      'dealConnected': true,
    },
    {
      'id': '2',
      'title': 'Sunset Rooftop Social',
      'category': 'nightlife',
      'description': 'Meet fellow travelers at the best rooftop in Casa',
      'host': {
        'name': 'Sarah Expat',
        'avatar': 'https://via.placeholder.com/50',
        'rating': 4.7,
        'isVerified': true,
      },
      'participants': 15,
      'maxParticipants': 25,
      'price': 120,
      'location': 'Casablanca Marina',
      'dateTime': 'Tomorrow 19:30',
      'duration': '4 hours',
      'tags': ['networking', 'rooftop', 'sunset'],
      'images': ['https://via.placeholder.com/300x200'],
      'venue': 'Sky Lounge Casa',
      'dealConnected': true,
    },
    {
      'id': '3',
      'title': 'Traditional Hammam Experience',
      'category': 'wellness',
      'description': 'Authentic Moroccan spa ritual with local guide',
      'host': {
        'name': 'Aicha Wellness',
        'avatar': 'https://via.placeholder.com/50',
        'rating': 5.0,
        'isVerified': true,
      },
      'participants': 6,
      'maxParticipants': 8,
      'price': 250,
      'location': 'Fez Medina',
      'dateTime': 'This Weekend',
      'duration': '2.5 hours',
      'tags': ['traditional', 'wellness', 'authentic'],
      'images': ['https://via.placeholder.com/300x200'],
      'venue': 'Hammam Traditionnel',
      'dealConnected': false,
    },
    {
      'id': '4',
      'title': 'Atlas Mountains Day Trip',
      'category': 'adventure',
      'description': 'Small group hiking with Berber village visit',
      'host': {
        'name': 'Omar Mountain Guide',
        'avatar': 'https://via.placeholder.com/50',
        'rating': 4.8,
        'isVerified': true,
      },
      'participants': 10,
      'maxParticipants': 16,
      'price': 380,
      'location': 'Imlil Village',
      'dateTime': 'Saturday 07:00',
      'duration': '8 hours',
      'tags': ['hiking', 'berber-culture', 'mountain'],
      'images': ['https://via.placeholder.com/300x200'],
      'venue': 'Atlas Mountains',
      'dealConnected': true,
    },
    {
      'id': '5',
      'title': 'Local Coffee Culture Deep Dive',
      'category': 'culture',
      'description': 'Traditional coffee ceremony and cultural exchange',
      'host': {
        'name': 'Hassan Cultural Guide',
        'avatar': 'https://via.placeholder.com/50',
        'rating': 4.9,
        'isVerified': true,
      },
      'participants': 4,
      'maxParticipants': 6,
      'price': 95,
      'location': 'Rabat Old Town',
      'dateTime': 'Today 15:00',
      'duration': '2 hours',
      'tags': ['coffee', 'cultural-exchange', 'intimate'],
      'images': ['https://via.placeholder.com/300x200'],
      'venue': 'Traditional Coffee House',
      'dealConnected': true,
    },
  ];

  List<Map<String, dynamic>> get _filteredExperiences {
    var experiences = _mockSocialExperiences;

    if (_selectedInterest != 'all') {
      experiences = experiences
          .where((exp) => exp['category'] == _selectedInterest)
          .toList();
    }

    return experiences;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: const EnhancedAppBar(
        title: 'Social Discovery',
        subtitle: 'Find authentic experiences through local connections',
        showBackButton: true,
        showGradient: true,
      ),
      body: Column(
        children: [
          SocialFiltersAndSearch(
            socialInterests: _socialInterests,
            selectedInterest: _selectedInterest,
            onInterestSelected: (interest) {
              setState(() {
                _selectedInterest = interest;
              });
            },
            onAdvancedFiltersPressed: () =>
                SocialActionHelpers.showAdvancedFilters(context),
          ),
          SocialTabBar(tabController: _tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SocialExperiencesTab(
                  filteredExperiences: _filteredExperiences,
                  socialInterests: _socialInterests,
                ),
                MyConnectionsTab(
                  onViewExperienceDetails: (exp) =>
                      SocialActionHelpers.viewExperienceDetails(context, exp),
                  onMessageConnection: (name) =>
                      SocialActionHelpers.messageConnection(context, name),
                ),
                CreateExperienceTab(
                  onStartHostApplication: () =>
                      SocialActionHelpers.startHostApplication(context),
                  onExploreCategory: (category) =>
                      SocialActionHelpers.exploreCategory(context, category),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "social_discovery_fab",
        onPressed: () => SocialActionHelpers.createNewExperience(context),
        backgroundColor: AppTheme.moroccoGreen,
        icon: const Icon(Icons.add),
        label: const Text('Host Experience'),
      ),
    );
  }
}
