import '../../../../deals/services/deal_validation_service.dart';
import '../../../../../utils/theme.dart';
import 'package:flutter/material.dart';
import 'validation_utils.dart';

class RatingDetailsWidget extends StatelessWidget {
  final DealRating rating;

  const RatingDetailsWidget({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ValidationUtils.buildStarRating(rating.averageRating),
                const SizedBox(width: 8),
                Text(
                  '${rating.averageRating.toStringAsFixed(1)} out of 5',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  '${rating.totalRatings} reviews',
                  style: const TextStyle(
                    color: AppTheme.secondaryText,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildRatingCategory('Value', rating.valueForMoney)),
                const SizedBox(width: 16),
                Expanded(child: _buildRatingCategory('Quality', rating.quality)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _buildRatingCategory('Service', rating.service)),
                const SizedBox(width: 16),
                Expanded(child: _buildRatingCategory('Authentic', rating.authenticity)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingCategory(String label, double rating) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.secondaryText,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: rating / 5.0,
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.moroccoGreen),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              rating.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}