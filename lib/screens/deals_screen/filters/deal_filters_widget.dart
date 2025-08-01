import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

/// Deal filtering modal widget with various filter options
class DealFiltersWidget extends StatefulWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;
  final String sortBy;
  final Function(String) onSortChanged;

  const DealFiltersWidget({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.sortBy,
    required this.onSortChanged,
  });

  @override
  State<DealFiltersWidget> createState() => _DealFiltersWidgetState();
}

class _DealFiltersWidgetState extends State<DealFiltersWidget> {
  late String _tempFilter;
  late String _tempSort;

  @override
  void initState() {
    super.initState();
    _tempFilter = widget.selectedFilter;
    _tempSort = widget.sortBy;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Text(
                'Filter Deals',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Filter by type
          const Text(
            'Filter by Type',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          _buildFilterChips(),
          
          const SizedBox(height: 24),

          // Sort by
          const Text(
            'Sort by',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          _buildSortOptions(),
          
          const Spacer(),

          // Apply button
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    widget.onFilterChanged('all');
                    widget.onSortChanged('ending_soon');
                    Navigator.pop(context);
                  },
                  child: const Text('Clear All'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onFilterChanged(_tempFilter);
                    widget.onSortChanged(_tempSort);
                    Navigator.pop(context);
                  },
                  child: const Text('Apply Filters'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = [
      {'key': 'all', 'label': 'All Deals', 'icon': '🔥'},
      {'key': 'active', 'label': 'Active Only', 'icon': '✅'},
      {'key': 'ending_soon', 'label': 'Ending Soon', 'icon': '⏰'},
      {'key': 'food', 'label': 'Food', 'icon': '🍕'},
      {'key': 'entertainment', 'label': 'Entertainment', 'icon': '🎮'},
      {'key': 'wellness', 'label': 'Wellness', 'icon': '💆'},
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: filters.map((filter) {
        final isSelected = _tempFilter == filter['key'];
        return FilterChip(
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              _tempFilter = filter['key']!;
            });
          },
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(filter['icon']!, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 4),
              Text(filter['label']!),
            ],
          ),
          selectedColor: AppTheme.moroccoGreen.withValues(alpha: 0.2),
          checkmarkColor: AppTheme.moroccoGreen,
        );
      }).toList(),
    );
  }

  Widget _buildSortOptions() {
    final sortOptions = [
      {'key': 'ending_soon', 'label': 'Ending Soon', 'icon': Icons.schedule},
      {'key': 'discount', 'label': 'Best Discount', 'icon': Icons.local_offer},
      {'key': 'distance', 'label': 'Nearest First', 'icon': Icons.location_on},
      {'key': 'rating', 'label': 'Highest Rated', 'icon': Icons.star},
    ];

    return Column(
      children: sortOptions.map((option) {
        return RadioListTile<String>(
          value: option['key']! as String,
          groupValue: _tempSort,
          onChanged: (value) {
            setState(() {
              _tempSort = value!;
            });
          },
          title: Row(
            children: [
              Icon(option['icon']! as IconData, size: 20),
              const SizedBox(width: 8),
              Text(option['label']! as String),
            ],
          ),
          activeColor: AppTheme.moroccoGreen,
          contentPadding: EdgeInsets.zero,
        );
      }).toList(),
    );
  }
}