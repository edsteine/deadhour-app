import 'package:flutter/material.dart';

class VenueReviewsTab extends StatelessWidget {
  final dynamic venue;

  const VenueReviewsTab({
    super.key,
    required this.venue,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overall rating
          Row(
            children: [
              const Text(
                '4.5',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStars(4.5),
                  const SizedBox(height: 4),
                  Text(
                    '${_getReviews().length} reviews',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Reviews list
          ..._getReviews().map((review) => _buildReviewCard(review)),
        ],
      ),
    );
  }

  Widget _buildStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return const Icon(Icons.star, color: Colors.amber, size: 20);
        } else if (index < rating) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 20);
        } else {
          return const Icon(Icons.star_border, color: Colors.grey, size: 20);
        }
      }),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  child: Text(
                    review['userName'][0].toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review['userName'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          _buildStars(review['rating'].toDouble()),
                          const SizedBox(width: 8),
                          Text(
                            review['date'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              review['comment'],
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getReviews() {
    return [
      {
        'userName': 'Ahmed Hassan',
        'rating': 5,
        'date': '2 days ago',
        'comment': 'Amazing traditional Moroccan food! The tagine was perfectly cooked and the atmosphere is very authentic. Perfect for tourists wanting to experience real Moroccan cuisine.',
      },
      {
        'userName': 'Marie Dubois',
        'rating': 4,
        'date': '1 week ago',
        'comment': 'Great service and delicious food. The mint tea was exceptional. Staff speaks multiple languages which made our visit very comfortable.',
      },
      {
        'userName': 'Omar Benali',
        'rating': 5,
        'date': '2 weeks ago',
        'comment': 'One of the best restaurants in Casablanca. Fresh ingredients, traditional recipes, and fair prices. Highly recommended for both locals and visitors.',
      },
    ];
  }
}