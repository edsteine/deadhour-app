import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/utils/mock_data.dart';
import 'package:deadhour/widgets/common/room_card.dart';
import 'package:deadhour/utils/constants.dart';

class EnhancedRoomSearch extends ConsumerStatefulWidget {
  final Function(dynamic room) onRoomSelected;

  const EnhancedRoomSearch({
    super.key,
    required this.onRoomSelected,
  });

  @override
  ConsumerState<EnhancedRoomSearch> createState() => _EnhancedRoomSearchState();
}

class _EnhancedRoomSearchState extends ConsumerState<EnhancedRoomSearch> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  String _searchQuery = '';
  String _selectedCategory = 'all';
  String _selectedCity = 'all';
  bool _showOnlyActive = false;
  bool _showPrayerTimeAware = false;
  bool _showHalalOnly = false;
  bool _showFilters = false;

  List<dynamic> get _filteredRooms {
    var rooms = MockData.rooms;

    // Search query filtering
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      rooms = rooms.where((room) {
        return room.name.toLowerCase().contains(query) ||
            room.description.toLowerCase().contains(query) ||
            room.category.toLowerCase().contains(query) ||
            room.tags.any((tag) => tag.toLowerCase().contains(query));
      }).toList();
    }

    // Category filtering
    if (_selectedCategory != 'all') {
      rooms =
          rooms.where((room) => room.category == _selectedCategory).toList();
    }

    // City filtering
    if (_selectedCity != 'all') {
      rooms = rooms.where((room) => room.city == _selectedCity).toList();
    }

    // Activity filtering
    if (_showOnlyActive) {
      rooms = rooms.where((room) => room.memberCount > 50).toList();
    }

    // Cultural filters
    if (_showPrayerTimeAware) {
      rooms = rooms.where((room) => room.isPrayerTimeAware).toList();
    }
    if (_showHalalOnly) {
      rooms = rooms.where((room) => room.isHalalOnly).toList();
    }

    // Sort by relevance and member count
    rooms.sort((a, b) {
      if (_searchQuery.isNotEmpty) {
        final aScore = _calculateRelevanceScore(a, _searchQuery);
        final bScore = _calculateRelevanceScore(b, _searchQuery);
        if (aScore != bScore) return bScore.compareTo(aScore);
      }
      return b.memberCount.compareTo(a.memberCount);
    });

    return rooms;
  }

  int _calculateRelevanceScore(dynamic room, String query) {
    int score = 0;
    final lowerQuery = query.toLowerCase();

    if (room.name.toLowerCase().contains(lowerQuery)) score += 10;
    if (room.category.toLowerCase().contains(lowerQuery)) score += 8;
    if (room.description.toLowerCase().contains(lowerQuery)) score += 5;

    for (final String tag in room.tags) {
      if (tag.toLowerCase().contains(lowerQuery)) score += 3;
    }

    return score;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(),
          _buildSearchBar(),
          if (_showFilters) _buildFilters(),
          _buildResults(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
          const Expanded(
            child: Text(
              'Discover Rooms',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
            icon: Icon(
              _showFilters ? Icons.filter_list_off : Icons.filter_list,
              color: _showFilters ? AppTheme.moroccoGreen : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        focusNode: _searchFocus,
        decoration: InputDecoration(
          hintText: 'Search rooms, topics, categories...',
          prefixIcon: const Icon(Icons.search),
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
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppTheme.moroccoGreen),
          ),
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filters',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          // Category filter
          _buildCategoryFilter(),
          const SizedBox(height: 12),

          // City filter
          _buildCityFilter(),
          const SizedBox(height: 12),

          // Toggle filters
          _buildToggleFilters(),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Category', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildFilterChip('All', 'all', _selectedCategory),
              ...AppConstants.businessCategories.map((category) {
                return _buildFilterChip(
                  '${category['icon']} ${category['name']}',
                  category['id']!,
                  _selectedCategory,
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCityFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('City', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildFilterChip('All Cities', 'all', _selectedCity),
              ...AppConstants.moroccoCities.map((city) {
                return _buildFilterChip(city, city, _selectedCity);
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, String value, String selectedValue) {
    final isSelected = selectedValue == value;
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppTheme.primaryText,
            fontSize: 12,
          ),
        ),
        selected: isSelected,
        selectedColor: AppTheme.moroccoGreen,
        backgroundColor: Colors.white,
        onSelected: (selected) {
          setState(() {
            if (selectedValue == _selectedCategory) {
              _selectedCategory = value;
            } else {
              _selectedCity = value;
            }
          });
        },
      ),
    );
  }

  Widget _buildToggleFilters() {
    return Row(
      children: [
        Expanded(
          child: CheckboxListTile(
            title: const Text('Active Only', style: TextStyle(fontSize: 14)),
            value: _showOnlyActive,
            onChanged: (value) {
              setState(() {
                _showOnlyActive = value ?? false;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            dense: true,
          ),
        ),
        Expanded(
          child: CheckboxListTile(
            title: const Text('Prayer Aware', style: TextStyle(fontSize: 14)),
            value: _showPrayerTimeAware,
            onChanged: (value) {
              setState(() {
                _showPrayerTimeAware = value ?? false;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            dense: true,
          ),
        ),
      ],
    );
  }

  Widget _buildResults() {
    final rooms = _filteredRooms;

    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  '${rooms.length} rooms found',
                  style: const TextStyle(
                    color: AppTheme.secondaryText,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                if (_searchQuery.isNotEmpty ||
                    _selectedCategory != 'all' ||
                    _selectedCity != 'all')
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        _searchQuery = '';
                        _selectedCategory = 'all';
                        _selectedCity = 'all';
                        _showOnlyActive = false;
                        _showPrayerTimeAware = false;
                        _showHalalOnly = false;
                      });
                    },
                    child: const Text('Clear all'),
                  ),
              ],
            ),
          ),
          Expanded(
            child: rooms.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: rooms.length,
                    itemBuilder: (context, index) {
                      return RoomCard(
                        room: rooms[index],
                        onTap: () {
                          widget.onRoomSelected(rooms[index]);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'No rooms found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryText,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Try adjusting your filters or search terms',
            style: TextStyle(
              color: AppTheme.secondaryText,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
