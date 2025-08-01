import 'package:flutter/material.dart';

class CulturalFilters extends StatelessWidget {
  final bool showPrayerTimeAware;
  final bool showHalalOnly;
  final ValueChanged<bool> onPrayerTimeAwareChanged;
  final ValueChanged<bool> onHalalOnlyChanged;

  const CulturalFilters({
    super.key,
    required this.showPrayerTimeAware,
    required this.showHalalOnly,
    required this.onPrayerTimeAwareChanged,
    required this.onHalalOnlyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cultural Filters',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text('Prayer Time Aware'),
            subtitle: const Text('Show rooms that consider prayer times'),
            value: showPrayerTimeAware,
            onChanged: onPrayerTimeAwareChanged,
          ),
          SwitchListTile(
            title: const Text('Halal Only'),
            subtitle: const Text('Show rooms focused on halal activities'),
            value: showHalalOnly,
            onChanged: onHalalOnlyChanged,
          ),
        ],
      ),
    );
  }
}
