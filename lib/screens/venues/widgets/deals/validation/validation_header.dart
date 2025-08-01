import 'package:flutter/material.dart';

import '../../../../deals/services/deal_validation_service.dart';
import 'validation_utils.dart';

class ValidationHeader extends StatelessWidget {
  final ValidationSummary summary;
  final DealRating? rating;

  const ValidationHeader({
    super.key,
    required this.summary,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ValidationUtils.getStatusColor(summary.communityStatus),
            ValidationUtils.getStatusColor(summary.communityStatus).withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ValidationUtils.buildStatusIcon(summary.communityStatus, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Community ${ValidationUtils.getStatusText(summary.communityStatus)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (rating != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        rating!.averageRating.toStringAsFixed(1),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildValidationBadge('✅', summary.confirmedCount, 'Confirmed'),
              const SizedBox(width: 12),
              _buildValidationBadge('🔥', summary.verifiedCount, 'Verified'),
              const SizedBox(width: 12),
              if (summary.warningCount > 0)
                _buildValidationBadge('⚠️', summary.warningCount, 'Warnings'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildValidationBadge(String icon, int count, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(icon, style: const TextStyle(fontSize: 14)),
        const SizedBox(width: 4),
        Text(
          '$count $label',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}