import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';

class RoomChatMessageFilters extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;

  const RoomChatMessageFilters({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('all', 'All Messages', Icons.chat, null),
                  const SizedBox(width: 8),
                  _buildFilterChip('deals', 'Deals', Icons.local_offer, Colors.red),
                  const SizedBox(width: 8),
                  _buildFilterChip('groups', 'Groups', Icons.group, Colors.blue),
                  const SizedBox(width: 8),
                  _buildFilterChip('questions', 'Questions', Icons.help, Colors.orange),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String filter, String label, IconData icon, Color? color) {
    final isSelected = selectedFilter == filter;
    return FilterChip(
      selected: isSelected,
      onSelected: (_) => onFilterChanged(filter),
      avatar: Icon(
        icon,
        size: 16,
        color: isSelected 
            ? Colors.white 
            : (color ?? AppTheme.secondaryText),
      ),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: isSelected 
              ? Colors.white 
              : AppTheme.secondaryText,
        ),
      ),
      backgroundColor: Colors.transparent,
      selectedColor: color ?? AppTheme.moroccoGreen,
      checkmarkColor: Colors.white,
      side: BorderSide(
        color: isSelected 
            ? (color ?? AppTheme.moroccoGreen) 
            : Colors.grey.shade300,
      ),
    );
  }
}