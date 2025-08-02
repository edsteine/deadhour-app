import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';

class SocialFiltersAndSearch extends StatefulWidget {
  final List<Map<String, dynamic>> socialInterests;
  final String selectedInterest;
  final ValueChanged<String> onInterestSelected;
  final VoidCallback onAdvancedFiltersPressed;

  const SocialFiltersAndSearch({
    super.key,
    required this.socialInterests,
    required this.selectedInterest,
    required this.onInterestSelected,
    required this.onAdvancedFiltersPressed,
  });

  @override
  State<SocialFiltersAndSearch> createState() => _SocialFiltersAndSearchState();
}

class _SocialFiltersAndSearchState extends State<SocialFiltersAndSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search experiences, hosts, locations...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: widget.onAdvancedFiltersPressed,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),
          const SizedBox(height: 16),

          // Interest Filter
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.socialInterests.length,
              itemBuilder: (context, index) {
                final interest = widget.socialInterests[index];
                final isSelected = widget.selectedInterest == interest['id'];

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    selected: isSelected,
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(interest['icon'] as String,
                            style: const TextStyle(fontSize: 14)),
                        const SizedBox(width: 4),
                        Text(interest['name'] as String,
                            style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                    selectedColor: AppTheme.moroccoGreen.withValues(alpha: 0.2),
                    onSelected: (selected) {
                      widget.onInterestSelected(interest['id']! as String);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
