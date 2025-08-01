import 'package:flutter/material.dart';

import '../../../../../utils/theme.dart';
import '../../../../deals/services/deal_validation_service.dart';
import 'validation_utils.dart';

class CompactValidationView extends StatelessWidget {
  final ValidationSummary summary;
  final DealRating? rating;

  const CompactValidationView({
    super.key,
    required this.summary,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ValidationUtils.getStatusColor(summary.communityStatus).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ValidationUtils.getStatusColor(summary.communityStatus).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          ValidationUtils.buildStatusIcon(summary.communityStatus),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ValidationUtils.getStatusText(summary.communityStatus),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: ValidationUtils.getStatusColor(summary.communityStatus),
                    fontSize: 12,
                  ),
                ),
                if (rating != null)
                  Row(
                    children: [
                      ValidationUtils.buildStarRating(rating!.averageRating, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        '${rating!.averageRating.toStringAsFixed(1)} (${rating!.totalRatings})',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppTheme.secondaryText,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          if (summary.totalValidations > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${summary.totalValidations}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}