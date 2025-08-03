import 'package:flutter/material.dart';
import '../../../utils/theme.dart';

class DiscoverTab extends StatefulWidget {
  final Function(String) buildSectionHeader;
  final Function() buildQuickDiscoveryGrid;
  final Function() buildTrendingExperiences;

  const DiscoverTab({
    super.key,
    required this.buildSectionHeader,
    required this.buildQuickDiscoveryGrid,
    required this.buildTrendingExperiences,
  });

  @override
  State<DiscoverTab> createState() => _DiscoverTabState();
}

class _DiscoverTabState extends State<DiscoverTab> with TickerProviderStateMixin {
  late TabController _discoverTabController;

  final List<Tab> _discoverTabs = [
    const Tab(text: 'Categories'),
    const Tab(text: 'Trending'),
    const Tab(text: 'Places'),
    const Tab(text: 'Planning'),
  ];

  @override
  void initState() {
    super.initState();
    _discoverTabController = TabController(length: _discoverTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _discoverTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Sub-tabs for Explore Morocco
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.all(16),
          child: TabBar(
            controller: _discoverTabController,
            labelColor: AppTheme.moroccoGreen,
            unselectedLabelColor: AppTheme.secondaryText,
            indicatorColor: AppTheme.moroccoGreen,
            labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            tabs: _discoverTabs,
          ),
        ),

        // Sub-tab content
        Expanded(
          child: TabBarView(
            controller: _discoverTabController,
            children: [
              // Categories tab - Discovery categories
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.buildSectionHeader('🌍 Tourism Categories'),
                    const SizedBox(height: 12),
                    widget.buildQuickDiscoveryGrid(),
                  ],
                ),
              ),

              // Trending tab - Trending experiences
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.buildSectionHeader('🔥 Trending Cultural Experiences'),
                    const SizedBox(height: 12),
                    widget.buildTrendingExperiences(),
                  ],
                ),
              ),

              // Places tab - Morocco places
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.buildSectionHeader('🏛️ Popular Places in Morocco'),
                    const SizedBox(height: 12),
                    _buildMoroccoPlaces(),
                  ],
                ),
              ),

              // Planning tab - Travel guidance
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.buildSectionHeader('🧭 Planning Your Morocco Experience'),
                    const SizedBox(height: 12),
                    _buildTourismGuidance(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTourismGuidance() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        children: [
          const Text(
            '🗺️ Get the Most from Your Morocco Visit',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Connect with local experts, discover authentic experiences, and navigate Morocco like a local.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildGuidanceFeature('👨‍🏫', 'Local\nExperts'),
              _buildGuidanceFeature('🎨', 'Cultural\nExperiences'),
              _buildGuidanceFeature('🏛️', 'Historic\nSites'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGuidanceFeature(String emoji, String text) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black87,
            height: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildMoroccoPlaces() {
    final places = [
      {'name': 'Marrakech', 'description': 'Imperial city with vibrant souks', 'icon': '🕌'},
      {'name': 'Casablanca', 'description': 'Modern economic capital', 'icon': '🏙️'},
      {'name': 'Fes', 'description': 'Ancient medina and cultural center', 'icon': '🏛️'},
      {'name': 'Chefchaouen', 'description': 'Blue pearl of Morocco', 'icon': '💙'},
      {'name': 'Sahara Desert', 'description': 'Endless dunes and star-filled nights', 'icon': '🐪'},
      {'name': 'Atlas Mountains', 'description': 'Breathtaking peaks and Berber villages', 'icon': '🏔️'},
    ];

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
}
