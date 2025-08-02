import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';

class TouristLocationSelector extends StatelessWidget {
  final String selectedCity;
  final Function(String) onCityChanged;

  const TouristLocationSelector({
    super.key,
    required this.selectedCity,
    required this.onCityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cities = ['Casablanca', 'Marrakech', 'Rabat', 'Fez', 'Tangier', 'Agadir'];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Explore Cities',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppTheme.spacing12),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cities.length,
            itemBuilder: (context, index) {
              final city = cities[index];
              final isSelected = city == selectedCity;
              
              return Padding(
                padding: const EdgeInsets.only(right: AppTheme.spacing8),
                child: FilterChip(
                  label: Text(city),
                  selected: isSelected,
                  onSelected: (selected) => onCityChanged(city),
                  selectedColor: AppTheme.moroccoGreen.withValues(alpha: 0.2),
                  checkmarkColor: AppTheme.moroccoGreen,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}