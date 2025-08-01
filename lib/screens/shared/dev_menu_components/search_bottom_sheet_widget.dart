import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:deadhour/utils/app_theme.dart';

/// Comprehensive Search Bottom Sheet Widget
class SearchBottomSheetWidget extends StatefulWidget {
  const SearchBottomSheetWidget({super.key});
  
  @override
  State<SearchBottomSheetWidget> createState() => _SearchBottomSheetWidgetState();
}

class _SearchBottomSheetWidgetState extends State<SearchBottomSheetWidget> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'all';
  String _selectedLocation = 'all';

  final List<Map<String, String>> _categories = [
    {'id': 'all', 'name': 'All', 'icon': '🔍'},
    {'id': 'deals', 'name': 'Deals', 'icon': '🏷️'},
    {'id': 'venues', 'name': 'Venues', 'icon': '🏪'},
    {'id': 'experiences', 'name': 'Experiences', 'icon': '🎯'},
    {'id': 'experts', 'name': 'Local Experts', 'icon': '👨‍🏫'},
    {'id': 'rooms', 'name': 'Community Rooms', 'icon': '👥'},
  ];

  final List<Map<String, String>> _locations = [
    {'id': 'all', 'name': 'All Morocco'},
    {'id': 'casablanca', 'name': 'Casablanca'},
    {'id': 'rabat', 'name': 'Rabat'},
    {'id': 'marrakech', 'name': 'Marrakech'},
    {'id': 'fes', 'name': 'Fes'},
    {'id': 'tangier', 'name': 'Tangier'},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Search header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search DeadHour...',
                      prefixIcon: const Icon(Icons.search,
                          color: AppTheme.moroccoGreen),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                              icon: const Icon(Icons.clear),
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:
                            const BorderSide(color: AppTheme.moroccoGreen),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Filters
          _buildFilters(),
          const SizedBox(height: 16),

          // Search results
          Expanded(
            child: _searchQuery.isEmpty
                ? _buildQuickActions()
                : _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Column(
      children: [
        // Category filters
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              final isSelected = _selectedCategory == category['id'];

              return Container(
                margin: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  selected: isSelected,
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(category['icon']!,
                          style: const TextStyle(fontSize: 14)),
                      const SizedBox(width: 4),
                      Text(category['name']!),
                    ],
                  ),
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = category['id']!;
                    });
                  },
                  selectedColor: AppTheme.moroccoGreen.withValues(alpha: 0.2),
                  checkmarkColor: AppTheme.moroccoGreen,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),

        // Location filter
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: DropdownButtonFormField<String>(
            value: _selectedLocation,
            decoration: InputDecoration(
              labelText: 'Location',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.location_on),
            ),
            items: _locations.map((location) {
              return DropdownMenuItem(
                value: location['id'],
                child: Text(location['name']!),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedLocation = value!;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    final quickActions = [
      {
        'title': 'Trending Deals',
        'subtitle': 'Hot deals ending soon',
        'icon': Icons.trending_up,
        'color': Colors.orange
      },
      {
        'title': 'Nearby Venues',
        'subtitle': 'Discover places around you',
        'icon': Icons.location_on,
        'color': Colors.blue
      },
      {
        'title': 'Active Rooms',
        'subtitle': 'Join ongoing conversations',
        'icon': Icons.people,
        'color': Colors.green
      },
      {
        'title': 'Local Experts',
        'subtitle': 'Connect with Moroccan guides',
        'icon': Icons.person_pin,
        'color': Colors.purple
      },
      {
        'title': 'Cultural Events',
        'subtitle': 'Traditional festivals & events',
        'icon': Icons.event,
        'color': Colors.red
      },
      {
        'title': 'Food & Dining',
        'subtitle': 'Best Moroccan cuisine deals',
        'icon': Icons.restaurant,
        'color': Colors.amber
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: quickActions.length,
      itemBuilder: (context, index) {
        final action = quickActions[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: (action['color'] as Color).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                action['icon'] as IconData,
                color: action['color'] as Color,
              ),
            ),
            title: Text(action['title'] as String),
            subtitle: Text(action['subtitle'] as String),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to relevant screen based on action
              Navigator.pop(context);
              _handleQuickAction(action['title'] as String);
            },
          ),
        );
      },
    );
  }

  Widget _buildSearchResults() {
    // Mock search results based on query and filters
    final results = _getSearchResults();

    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No results found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your search or filters',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppTheme.moroccoGreen.withValues(alpha: 0.1),
              child: Text(
                result['icon'] as String,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            title: Text(result['title'] as String),
            subtitle: Text(result['subtitle'] as String),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                result['type'] as String,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.moroccoGreen,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              _handleSearchResult(result);
            },
          ),
        );
      },
    );
  }

  List<Map<String, String>> _getSearchResults() {
    if (_searchQuery.length < 2) return [];

    // Mock search results - in real app, this would call an API
    final allResults = [
      {
        'title': 'Pizza Corner',
        'subtitle': '30% off during 3-5 PM',
        'type': 'Deal',
        'icon': '🍕',
        'category': 'deals'
      },
      {
        'title': 'Café Central',
        'subtitle': 'Best coffee in Casablanca',
        'type': 'Venue',
        'icon': '☕',
        'category': 'venues'
      },
      {
        'title': 'Hassan II Mosque Tour',
        'subtitle': 'Guided cultural experience',
        'type': 'Experience',
        'icon': '🕌',
        'category': 'experiences'
      },
      {
        'title': 'Food Lovers Room',
        'subtitle': '152 members talking about food',
        'type': 'Room',
        'icon': '🍽️',
        'category': 'rooms'
      },
      {
        'title': 'Ahmed - Local Guide',
        'subtitle': 'Expert in Marrakech medina',
        'type': 'Expert',
        'icon': '👨‍🏫',
        'category': 'experts'
      },
      {
        'title': 'Tajine Workshop',
        'subtitle': 'Learn traditional cooking',
        'type': 'Experience',
        'icon': '🍲',
        'category': 'experiences'
      },
    ];

    return allResults.where((result) {
      final matchesQuery =
          result['title']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              result['subtitle']!
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase());
      final matchesCategory =
          _selectedCategory == 'all' || result['category'] == _selectedCategory;
      return matchesQuery && matchesCategory;
    }).toList();
  }

  void _handleQuickAction(String action) {
    switch (action) {
      case 'Trending Deals':
        context.go('/deals');
        break;
      case 'Nearby Venues':
        context.go('/venues');
        break;
      case 'Active Rooms':
        context.go('/community');
        break;
      case 'Local Experts':
        context.go('/local-expert');
        break;
      case 'Cultural Events':
        context.go('/tourism');
        break;
      case 'Food & Dining':
        context.go('/deals');
        break;
    }
  }

  void _handleSearchResult(Map<String, String> result) {
    switch (result['type']) {
      case 'Deal':
        context.go('/deals');
        break;
      case 'Venue':
        context.go('/venues');
        break;
      case 'Experience':
        context.go('/tourism');
        break;
      case 'Room':
        context.go('/community');
        break;
      case 'Expert':
        context.go('/local-expert');
        break;
    }
  }
}