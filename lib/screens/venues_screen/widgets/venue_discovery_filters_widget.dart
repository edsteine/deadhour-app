import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

/// Venue discovery filters widget with category, city, and preferences
class VenueDiscoveryFiltersWidget extends StatelessWidget {
  final String selectedCategory;
  final String selectedCity;
  final String sortBy;
  final double maxDistance;
  final bool openNowOnly;
  final String priceRange;
  final bool halalOnly;
  final bool prayerFriendly;
  final bool showCommunityActivity;
  final Function(String) onCategoryChanged;
  final Function(String) onCityChanged;
  final Function(String) onSortByChanged;
  final Function(double) onMaxDistanceChanged;
  final Function(bool) onOpenNowChanged;
  final Function(String) onPriceRangeChanged;
  final Function(bool) onHalalOnlyChanged;
  final Function(bool) onPrayerFriendlyChanged;
  final Function(bool) onShowCommunityActivityChanged;
  final VoidCallback onClearAll;

  const VenueDiscoveryFiltersWidget({
    super.key,
    required this.selectedCategory,
    required this.selectedCity,
    required this.sortBy,
    required this.maxDistance,
    required this.openNowOnly,
    required this.priceRange,
    required this.halalOnly,
    required this.prayerFriendly,
    required this.showCommunityActivity,
    required this.onCategoryChanged,
    required this.onCityChanged,
    required this.onSortByChanged,
    required this.onMaxDistanceChanged,
    required this.onOpenNowChanged,
    required this.onPriceRangeChanged,
    required this.onHalalOnlyChanged,
    required this.onPrayerFriendlyChanged,
    required this.onShowCommunityActivityChanged,
    required this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        children: [
          const Icon(Icons.filter_list, size: 20),
          const SizedBox(width: 8),
          const Text('Filters'),
          const Spacer(),
          if (_hasActiveFilters())
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Active',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category filter
              _buildSectionTitle('Category'),
              _buildCategoryFilter(),
              const SizedBox(height: 16),
              
              // Location filter
              _buildSectionTitle('Location'),
              _buildLocationFilter(),
              const SizedBox(height: 16),
              
              // Cultural preferences
              _buildSectionTitle('Cultural Preferences'),
              _buildCulturalPreferences(),
              const SizedBox(height: 16),
              
              // Other filters
              _buildSectionTitle('Other Filters'),
              _buildOtherFilters(),
              const SizedBox(height: 16),
              
              // Sort and display options
              _buildSectionTitle('Sort & Display'),
              _buildSortOptions(),
              const SizedBox(height: 16),
              
              // Clear filters button
              if (_hasActiveFilters())
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: onClearAll,
                    icon: const Icon(Icons.clear_all),
                    label: const Text('Clear All Filters'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.moroccoGreen,
                      side: const BorderSide(color: AppTheme.moroccoGreen),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppTheme.primaryText,
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    const categories = [
      {'id': 'all', 'name': 'All Categories', 'icon': '🏢'},
      {'id': 'food', 'name': 'Food & Dining', 'icon': '🍕'},
      {'id': 'entertainment', 'name': 'Entertainment', 'icon': '🎮'},
      {'id': 'wellness', 'name': 'Wellness', 'icon': '💆'},
      {'id': 'tourism', 'name': 'Tourism', 'icon': '🌍'},
      {'id': 'sports', 'name': 'Sports', 'icon': '⚽'},
      {'id': 'family', 'name': 'Family', 'icon': '👨‍👩‍👧‍👦'},
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories.map((category) {
        final isSelected = selectedCategory == category['id'];
        return FilterChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(category['icon']!, style: const TextStyle(fontSize: 14)),
              const SizedBox(width: 4),
              Text(category['name']!, style: const TextStyle(fontSize: 12)),
            ],
          ),
          selected: isSelected,
          onSelected: (_) => onCategoryChanged(category['id']!),
          selectedColor: AppTheme.moroccoGreen.withValues(alpha: 0.2),
          checkmarkColor: AppTheme.moroccoGreen,
        );
      }).toList(),
    );
  }

  Widget _buildLocationFilter() {
    const cities = [
      {'id': 'all', 'name': 'All Cities'},
      {'id': 'casablanca', 'name': 'Casablanca'},
      {'id': 'rabat', 'name': 'Rabat'},
      {'id': 'marrakech', 'name': 'Marrakech'},
      {'id': 'fes', 'name': 'Fes'},
      {'id': 'tangier', 'name': 'Tangier'},
    ];

    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: selectedCity,
          decoration: const InputDecoration(
            labelText: 'City',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: cities.map((city) {
            return DropdownMenuItem<String>(
              value: city['id']!,
              child: Text(city['name']!),
            );
          }).toList(),
          onChanged: (value) => onCityChanged(value!),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Text('Max Distance: '),
            Expanded(
              child: Slider(
                value: maxDistance,
                min: 1,
                max: 50,
                divisions: 49,
                label: '${maxDistance.round()} km',
                onChanged: onMaxDistanceChanged,
                activeColor: AppTheme.moroccoGreen,
              ),
            ),
            Text('${maxDistance.round()} km'),
          ],
        ),
      ],
    );
  }

  Widget _buildCulturalPreferences() {
    return Column(
      children: [
        CheckboxListTile(
          title: const Row(
            children: [
              Text('🍖', style: TextStyle(fontSize: 16)),
              SizedBox(width: 8),
              Text('Halal Food Only', style: TextStyle(fontSize: 14)),
            ],
          ),
          value: halalOnly,
          onChanged: (value) => onHalalOnlyChanged(value!),
          activeColor: AppTheme.moroccoGreen,
          contentPadding: EdgeInsets.zero,
        ),
        CheckboxListTile(
          title: const Row(
            children: [
              Text('🕌', style: TextStyle(fontSize: 16)),
              SizedBox(width: 8),
              Text('Prayer-Friendly', style: TextStyle(fontSize: 14)),
            ],
          ),
          value: prayerFriendly,
          onChanged: (value) => onPrayerFriendlyChanged(value!),
          activeColor: AppTheme.moroccoGreen,
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }

  Widget _buildOtherFilters() {
    const priceRanges = [
      {'id': 'all', 'name': 'All Prices'},
      {'id': 'budget', 'name': '€ - Budget'},
      {'id': 'moderate', 'name': '€€ - Moderate'},
      {'id': 'upscale', 'name': '€€€ - Upscale'},
    ];

    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: priceRange,
          decoration: const InputDecoration(
            labelText: 'Price Range',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: priceRanges.map((range) {
            return DropdownMenuItem<String>(
              value: range['id']!,
              child: Text(range['name']!),
            );
          }).toList(),
          onChanged: (value) => onPriceRangeChanged(value!),
        ),
        const SizedBox(height: 8),
        CheckboxListTile(
          title: const Text('Open Now Only', style: TextStyle(fontSize: 14)),
          value: openNowOnly,
          onChanged: (value) => onOpenNowChanged(value!),
          activeColor: AppTheme.moroccoGreen,
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }

  Widget _buildSortOptions() {
    const sortOptions = [
      {'id': 'rating', 'name': 'Rating'},
      {'id': 'distance', 'name': 'Distance'},
      {'id': 'popularity', 'name': 'Popularity'},
      {'id': 'price', 'name': 'Price'},
    ];

    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: sortBy,
          decoration: const InputDecoration(
            labelText: 'Sort By',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: sortOptions.map((option) {
            return DropdownMenuItem<String>(
              value: option['id']!,
              child: Text(option['name']!),
            );
          }).toList(),
          onChanged: (value) => onSortByChanged(value!),
        ),
        const SizedBox(height: 8),
        CheckboxListTile(
          title: const Text('Show Community Activity', style: TextStyle(fontSize: 14)),
          value: showCommunityActivity,
          onChanged: (value) => onShowCommunityActivityChanged(value!),
          activeColor: AppTheme.moroccoGreen,
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }

  bool _hasActiveFilters() {
    return selectedCategory != 'all' ||
        selectedCity != 'all' ||
        openNowOnly ||
        halalOnly ||
        prayerFriendly ||
        priceRange != 'all' ||
        maxDistance != 10.0;
  }
}