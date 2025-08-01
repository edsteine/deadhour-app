import 'package:deadhour/utils/app_theme.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/theme.dart';
import '../services/map_data_service.dart';

/// Filter chips for categorizing map locations
class MapFilterChips extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;

  const MapFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final mapDataService = MapDataService();
    final filters = mapDataService.getFilterOptions();

    return Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      left: 16,
      right: 80,
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: filters.length,
          itemBuilder: (context, index) {
            final filter = filters[index];
            final isSelected = selectedFilter == filter['id'];

            return Container(
              margin: const EdgeInsets.only(right: 8),
              child: FilterChip(
                selected: isSelected,
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(filter['icon']!, style: const TextStyle(fontSize: 12)),
                    const SizedBox(width: 4),
                    Text(filter['name']!),
                  ],
                ),
                onSelected: (selected) => onFilterChanged(filter['id']!),
                selectedColor: AppTheme.moroccoGreen.withValues(alpha: 0.2),
                checkmarkColor: AppTheme.moroccoGreen,
              ),
            );
          },
        ),
      ),
    );
  }
}