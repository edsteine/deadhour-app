import 'package:deadhour/utils/haptic_feedback_type.dart';

import 'package:deadhour/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:deadhour/utils/performance_utils.dart';

/// Deals filter bottom sheet widget
class DealsFilters {
  static void show(BuildContext context) {
    PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Deal Filters',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLocationSection(context),
                    const SizedBox(height: 16),
                    _buildQuickFiltersSection(),
                    const SizedBox(height: 16),
                    _buildCategoriesSection(),
                    const SizedBox(height: 16),
                    _buildSortSection(),
                    const SizedBox(height: 16),
                    _buildPriceRangeSection(),
                    const SizedBox(height: 16),
                    _buildDealTypeSection(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  static Widget _buildLocationSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Location', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: const Icon(Icons.location_on, color: AppTheme.moroccoGreen),
            title: const Text('Casablanca'),
            subtitle: const Text('Current location'),
            trailing: const Icon(Icons.keyboard_arrow_down),
            onTap: () => _showLocationPicker(context),
          ),
        ),
      ],
    );
  }

  static Widget _buildQuickFiltersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Quick Filters', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            FilterChip(label: const Text('All Deals'), onSelected: (selected) {}),
            FilterChip(label: const Text('Ending Soon'), onSelected: (selected) {}),
            FilterChip(label: const Text('Active Only'), onSelected: (selected) {}),
          ],
        ),
      ],
    );
  }

  static Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Categories', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        ...['🍕 Food', '🎮 Entertainment', '💆 Wellness', '⚽ Sports'].map(
          (category) => CheckboxListTile(
            title: Text(category),
            value: false,
            onChanged: (value) {},
            dense: true,
          ),
        ),
      ],
    );
  }

  static Widget _buildSortSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Sort By', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        ...['Ending Soon', 'Best Discount', 'Nearest', 'Highest Rated'].map(
          (sort) => RadioListTile<String>(
            title: Text(sort),
            value: sort.toLowerCase().replaceAll(' ', '_'),
            groupValue: 'ending_soon',
            onChanged: (value) {},
            dense: true,
          ),
        ),
      ],
    );
  }

  static Widget _buildPriceRangeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Price Range', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        ...['Any Price', 'Under 50 MAD', '50-100 MAD', 'Over 100 MAD'].map(
          (price) => CheckboxListTile(
            title: Text(price),
            value: false,
            onChanged: (value) {},
            dense: true,
          ),
        ),
      ],
    );
  }

  static Widget _buildDealTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Deal Type', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        ...['Flash Deals', 'Group Discounts', 'Happy Hour', 'Weekend Specials'].map(
          (type) => CheckboxListTile(
            title: Text(type),
            value: false,
            onChanged: (value) {},
            dense: true,
          ),
        ),
      ],
    );
  }

  static Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Clear All'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Apply Filters'),
          ),
        ),
      ],
    );
  }

  static void _showLocationPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select City'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...['Casablanca', 'Rabat', 'Marrakech', 'Fes', 'Tangier', 'Agadir'].map(
              (city) => ListTile(
                title: Text(city),
                onTap: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}