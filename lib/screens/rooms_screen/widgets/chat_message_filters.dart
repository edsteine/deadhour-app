import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

/// Message filter chips for categorizing chat messages
class ChatMessageFilters extends StatelessWidget {
  final String currentFilter;
  final Function(String) onFilterChanged;

  const ChatMessageFilters({
    super.key,
    required this.currentFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('all', 'All', Icons.chat),
                  _buildFilterChip('deals', 'Deals', Icons.local_offer),
                  _buildFilterChip('groups', 'Groups', Icons.people),
                  _buildFilterChip('questions', 'Q&A', Icons.help_outline),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String filter, String label, IconData icon) {
    final isSelected = currentFilter == filter;
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: isSelected,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 4),
            Text(label),
          ],
        ),
        onSelected: (selected) => onFilterChanged(filter),
        selectedColor: AppTheme.moroccoGreen.withValues(alpha: 0.2),
        checkmarkColor: AppTheme.moroccoGreen,
      ),
    );
  }
}