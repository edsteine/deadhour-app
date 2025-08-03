import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../utils/theme.dart';
import '../../../utils/mock_data.dart';
import '../../../models/deal.dart';

class TouristTrendingDeals extends StatelessWidget {
  const TouristTrendingDeals({super.key});

  @override
  Widget build(BuildContext context) {
    final trendingDeals = MockData.deals.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Trending Dead Hour Deals',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () => context.push('/deals'),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacing12),
        ...trendingDeals.map((deal) => Padding(
          padding: const EdgeInsets.only(bottom: AppTheme.spacing12),
          child: _buildTrendingDealCard(deal),
        )),
      ],
    );
  }

  Widget _buildTrendingDealCard(Deal deal) {
    final venue = MockData.venues.firstWhere(
      (v) => v.id == deal.venueId,
      orElse: () => MockData.venues.first,
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              child: Image.network(
                venue.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image),
                  );
                },
              ),
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    deal.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    venue.name,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${((deal.originalPrice - deal.discountedPrice) / deal.originalPrice * 100).round()}% OFF',
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacing8),
                      Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 2),
                      Text(
                        'Until ${deal.validUntil}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${deal.discountedPrice} MAD',
                  style: const TextStyle(
                    color: AppTheme.moroccoGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (deal.originalPrice != deal.discountedPrice)
                  Text(
                    '${deal.originalPrice} MAD',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}