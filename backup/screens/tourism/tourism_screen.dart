import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/theme.dart';
import '../../providers/role_toggle_provider.dart';
import '../../models/user.dart';
import 'widgets/local_experts_tab.dart';
import 'widgets/experiences_tab.dart';
import 'widgets/cultural_tab.dart';
import 'widgets/quick_discovery_grid.dart';
import 'widgets/trending_experiences.dart';
import 'widgets/cultural_dashboard.dart';
import 'widgets/cultural_events.dart';
import 'widgets/cultural_tips.dart';

class TourismScreen extends ConsumerStatefulWidget {
  const TourismScreen({super.key});

  @override
  ConsumerState<TourismScreen> createState() => _TourismScreenState();
}

class _TourismScreenState extends ConsumerState<TourismScreen>
    with TickerProviderStateMixin {
  String _selectedCity = 'Casablanca';
  late TabController _tourismTabController;

  final List<Tab> _tourismTabs = [
    const Tab(text: 'Categories'),
    const Tab(text: 'Trending'),
    const Tab(text: 'Places'),
    const Tab(text: 'Local Experts'),
    const Tab(text: 'Experiences'), 
    const Tab(text: 'Cultural'),
  ];

  bool _isPremiumUser = false;
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
    _isPremiumUser = ref.read(roleToggleProvider) == UserRole.premium;
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

  Widget _buildMoroccoPlaces() {
    final allPlaces = [
      {'name': 'Marrakech', 'description': 'Imperial city with vibrant souks', 'icon': '🕌', 'region': 'Marrakech'},
      {'name': 'Casablanca', 'description': 'Modern economic capital', 'icon': '🏙️', 'region': 'Casablanca'},
      {'name': 'Fes', 'description': 'Ancient medina and cultural center', 'icon': '🏛️', 'region': 'Fes'},
      {'name': 'Chefchaouen', 'description': 'Blue pearl of Morocco', 'icon': '💙', 'region': 'Tangier'},
      {'name': 'Sahara Desert', 'description': 'Endless dunes and star-filled nights', 'icon': '🐪', 'region': 'Agadir'},
      {'name': 'Atlas Mountains', 'description': 'Breathtaking peaks and Berber villages', 'icon': '🏔️', 'region': 'Marrakech'},
    ];

    // Filter places based on selected city
    final places = allPlaces.where((place) {
      return place['region'] == _selectedCity || place['name'] == _selectedCity;
    }).toList();

    return Column(
      children: places.map((place) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(place['icon']!, style: const TextStyle(fontSize: 24)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place['name']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    place['description']!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      )).toList(),
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

  Widget _buildCitySelector() {
    final cities = ['Casablanca', 'Marrakech', 'Fes', 'Rabat', 'Tangier', 'Agadir'];
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_city, color: AppTheme.moroccoGreen),
          const SizedBox(width: 12),
          const Text(
            'City:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCity,
                icon: const Icon(Icons.arrow_drop_down),
                isExpanded: true,
                items: cities.map((String city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedCity = newValue;
                    });
                    // Filter tourism content by selected city
                    debugPrint('Selected city: $_selectedCity');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Showing tourism content for $_selectedCity'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () => _showCityFilterDialog(),
            icon: const Icon(Icons.filter_list, size: 18),
            label: const Text('Filter'),
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.moroccoGreen,
            ),
          ),
          IconButton(
            onPressed: _handleMenuPress,
            icon: const Icon(Icons.more_vert, size: 20),
            color: AppTheme.moroccoGreen,
            tooltip: 'Tourism menu',
          ),
        ],
      ),
    );
  }

  void _showCityFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tourism Filters'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Filter tourism experiences by:'),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text('Cultural Sites'),
              value: true,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: const Text('Adventure Activities'),
              value: false,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: const Text('Food Experiences'),
              value: true,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: const Text('Local Guides Available'),
              value: false,
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              debugPrint('Applied tourism filters for $_selectedCity');
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // City selector header
        _buildCitySelector(),
        
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
              // Categories tab - Tourism discovery categories
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('🌍 Tourism Categories'),
                    const SizedBox(height: 12),
                    if (_isPremiumUser) 
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.amber.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.amber),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Premium: Access to exclusive tours and expert guides!',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    const QuickDiscoveryGrid(),
                  ],
                ),
              ),
              
              // Trending tab - Trending cultural experiences
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('🔥 Trending Cultural Experiences'),
                    const SizedBox(height: 12),
                    const TrendingExperiences(),
                  ],
                ),
              ),
              
              // Places tab - Popular places in Morocco
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('🏛️ Popular Places in Morocco'),
                    const SizedBox(height: 12),
                    _buildMoroccoPlaces(),
                  ],
                ),
              ),
              
              // Local Experts tab - List of advisors/guides
              LocalExpertsTab(
                buildSectionHeader: _buildSectionHeader,
                buildExpertCard: (expert) => _buildExpertCard(expert),
                experts: _experts,
              ),
              // Experiences tab - Authentic activities
              ExperiencesTab(
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

  void _handleMenuPress() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tourism Menu',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('My Bookings'),
              subtitle: const Text('View and manage your tourism bookings'),
              onTap: () {
                Navigator.pop(context);
                debugPrint('Navigate to tourism bookings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Saved Experiences'),
              subtitle: const Text('Your favorite places and activities'),
              onTap: () {
                Navigator.pop(context);
                debugPrint('Navigate to saved experiences');
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Find Local Guides'),
              subtitle: const Text('Connect with certified local experts'),
              onTap: () {
                Navigator.pop(context);
                _handleExpertRequest();
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Tourism Preferences'),
              subtitle: const Text('Set your travel preferences and interests'),
              onTap: () {
                Navigator.pop(context);
                debugPrint('Navigate to tourism settings');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleExpertRequest() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.person_search, color: AppTheme.moroccoGreen),
            SizedBox(width: 12),
            Text('Request Local Expert'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Get personalized recommendations from local experts in $_selectedCity.',
            ),
            const SizedBox(height: 16),
            const Text(
              'What are you interested in?',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Wrap(
              spacing: 8,
              children: [
                Chip(label: Text('Cultural Sites')),
                Chip(label: Text('Food & Dining')),
                Chip(label: Text('Adventure')),
                Chip(label: Text('Shopping')),
                Chip(label: Text('Nightlife')),
              ],
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Tell us more about what you\'re looking for...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showExpertRequestConfirmation();
            },
            child: const Text('Submit Request'),
          ),
        ],
      ),
    );
  }

  void _showExpertRequestConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Request Submitted!'),
        content: const Text(
          'Your expert request has been submitted. A local guide will contact you within 2 hours with personalized recommendations.',
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Great!'),
          ),
        ],
      ),
    );
  }
}
