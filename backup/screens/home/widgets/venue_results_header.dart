import 'package:flutter/material.dart';
import '../../../utils/theme.dart';

class VenueResultsHeader extends StatelessWidget {
  final int venueCount;
  final bool hasActiveFilters;
  final VoidCallback onClearFilters;

  const VenueResultsHeader({
    super.key,
    required this.venueCount,
    required this.hasActiveFilters,
    required this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          Text(
            '$venueCount venues found',
            style: const TextStyle(
              fontSize: 16,
              color: AppTheme.primaryText,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          // Show active filters indicator if any are applied
          if (hasActiveFilters)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Filters Active',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.moroccoGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: onClearFilters,
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: AppTheme.moroccoGreen,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}