import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';



/// Venue reviews and ratings widget
class VenueReviewsWidget extends StatelessWidget {
  final dynamic venue;
  final SocialValidationService socialValidation;

  const VenueReviewsWidget({
    super.key,
    required this.venue,
    required this.socialValidation,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rating summary
          Row(
            children: [
              Text(
                venue.rating.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.moroccoGreen,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < venue.rating.floor()
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 20,
                        );
                      }),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '127 reviews',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Sample reviews
          ..._buildSampleReviews(),
          
          // Social validation section
          _buildSocialValidationSection(),
        ],
      ),
    );
  }

  List<Widget> _buildSampleReviews() {
    final reviews = [
      {
        'name': 'Ahmed K.',
        'rating': 5,
        'time': '2 days ago',
        'comment': 'Excellent food and great atmosphere! The deals during dead hours are amazing value.',
      },
      {
        'name': 'Sarah M.',
        'rating': 4,
        'time': '1 week ago',
        'comment': 'Love the halal options and the staff is very friendly. Perfect for families.',
      },
      {
        'name': 'Tourist_Guide',
        'rating': 5,
        'time': '2 weeks ago',
        'comment': 'Discovered this place through the community. Authentic Moroccan experience!',
      },
    ];

    return reviews.map((review) {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppTheme.moroccoGreen,
                  child: Text(
                    review['name'].toString().substring(0, 1),
                    style: const TextStyle(
                      color: Colors.white,
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
                        review['name'] as String,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          ...List.generate(5, (index) {
                            return Icon(
                              index < (review['rating'] as int)
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 16,
                            );
                          }),
                          const SizedBox(width: 8),
                          Text(
                            review['time'] as String,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.secondaryText,
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
              review['comment'] as String,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildSocialValidationSection() {
    final checkIns = socialValidation.getVenueCheckIns(venue.id);
    final socialProof = socialValidation.getSocialProofSummary(venue.id);
    final friendRecommendation = socialValidation.getFriendRecommendation(venue.id);
    final trustIndicators = socialValidation.getTrustIndicators(venue.id);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const Text(
          '👥 Community Validation',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        
        // Trust indicators
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.verified_user,
                    size: 20,
                    color: _getTrustLevelColor(trustIndicators['trustLevel']),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    trustIndicators['trustLevel'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _getTrustLevelColor(trustIndicators['trustLevel']),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getTrustLevelColor(trustIndicators['trustLevel']).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${trustIndicators['trustScore'].toInt()}% trust',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _getTrustLevelColor(trustIndicators['trustLevel']),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (trustIndicators['indicators'].isNotEmpty)
                Wrap(
                  spacing: 6,
                  children: trustIndicators['indicators'].map<Widget>((indicator) => Chip(
                    label: Text(
                      indicator,
                      style: const TextStyle(fontSize: 11),
                    ),
                    backgroundColor: Colors.green.shade50,
                    side: BorderSide(color: Colors.green.shade200),
                  )).toList(),
                ),
            ],
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Friend recommendation if available
        if (friendRecommendation != null) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person, color: Colors.blue, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      'Recommended by ${friendRecommendation['friendName']}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  '"${friendRecommendation['recommendation']}"',
                  style: const TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
        
        // Recent community activity
        if (checkIns.isNotEmpty) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recent Community Activity:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                ...checkIns.take(3).map((checkIn) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        checkIn['isFriend'] ? Icons.person : Icons.account_circle,
                        size: 16,
                        color: checkIn['isFriend'] ? Colors.green : Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  checkIn['username'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: checkIn['isFriend'] ? Colors.green : Colors.black87,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Row(
                                  children: List.generate(5, (index) => Icon(
                                    index < checkIn['rating'] ? Icons.star : Icons.star_border,
                                    size: 12,
                                    color: Colors.amber,
                                  )),
                                ),
                              ],
                            ),
                            if (checkIn['comment'].isNotEmpty)
                              Text(
                                checkIn['comment'],
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Color _getTrustLevelColor(String? trustLevel) {
    switch (trustLevel) {
      case 'Highly Trusted':
        return Colors.green;
      case 'Community Trusted':
        return Colors.blue;
      case 'Moderately Trusted':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}