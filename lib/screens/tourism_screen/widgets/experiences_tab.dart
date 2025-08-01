
import 'package:flutter/material.dart';

import 'package:deadhour/utils/app_theme.dart';

class TourismExperiencesTab extends StatefulWidget {
  final Function(String) buildSectionHeader;
  final Function(Map<String, String>) buildExperienceCard;

  const TourismExperiencesTab({
    super.key,
    required this.buildSectionHeader,
    required this.buildExperienceCard,
  });

  @override
  State<TourismExperiencesTab> createState() => _TourismExperiencesTabState();
}

class _TourismExperiencesTabState extends State<TourismExperiencesTab> {
  final RealTimeBookingService _bookingService = RealTimeBookingService();

  final List<Map<String, String>> _experiences = [
    {
      'id': 'traditional_cooking_class',
      'title': '🍽️ Home Cooking with Local Family',
      'description': 'Cook tagine and couscous in authentic setting',
      'price': '3 hours • Real-time Booking • All languages',
      'icon': 'Icons.home',
      'color': 'Colors.green',
    },
    {
      'id': 'pottery_workshop',
      'title': '🏺 Traditional Pottery Workshop',
      'description': 'Learn from master craftsmen in Fez medina',
      'price': '2 hours • Real-time Booking • English/French',
      'icon': 'Icons.handyman',
      'color': 'Colors.orange',
    },
    {
      'id': 'cultural_exchange',
      'title': '🕌 Spiritual Journey & Prayer Experience',
      'description': 'Respectful mosque visit with cultural guide',
      'price': '90 min • Real-time Booking • Modest dress required',
      'icon': 'Icons.mosque',
      'color': 'Colors.blue',
    },
    {
      'id': 'souk_shopping_tour',
      'title': '🛒 Souk Navigation Masterclass',
      'description': 'Bargaining secrets and hidden shop discoveries',
      'price': '2 hours • Real-time Booking • Small groups only',
      'icon': 'Icons.shopping_bag',
      'color': 'Colors.purple',
    },
  ];

  @override
  void initState() {
    super.initState();
    _bookingService.initializeBookingService();
  }

  void _showBookingSheet(Map<String, String> experience) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: RealTimeBookingWidget(
          experienceId: experience['id']!,
          experienceTitle: experience['title']!,
          experienceDescription: experience['description']!,
          userId: 'current_user_id',
        ),
      ),
    );
  }

  Widget _buildEnhancedExperienceCard(Map<String, String> experience) {
    final availability = _bookingService.getAvailability(experience['id']!);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        experience['title']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    if (availability != null) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: availability.isAvailable 
                              ? AppTheme.moroccoGreen.withValues(alpha: 0.1)
                              : Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              availability.isAvailable ? Icons.check_circle : Icons.schedule,
                              size: 12,
                              color: availability.isAvailable ? AppTheme.moroccoGreen : Colors.red,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              availability.isAvailable ? 'Available' : 'Limited',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: availability.isAvailable ? AppTheme.moroccoGreen : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  experience['description']!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        experience['price']!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    if (availability != null) ...[
                      Text(
                        'From ${availability.averagePrice.toInt()} MAD',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.moroccoGreen,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          
          // Real-time booking section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            child: Column(
              children: [
                if (availability != null && availability.isAvailable) ...[
                  Row(
                    children: [
                      const Icon(Icons.schedule, size: 16, color: AppTheme.moroccoGreen),
                      const SizedBox(width: 8),
                      Text(
                        'Next available: ${_formatNextSlot(availability.nextAvailableSlot)}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.secondaryText,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${availability.availableSlots} slots today',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.moroccoGreen,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
                
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _showBookingSheet(experience),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.moroccoGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.flash_on, size: 18),
                    label: const Text(
                      'Book Now - Instant Confirmation',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                
                const SizedBox(height: 8),
                
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cancel_outlined, size: 12, color: AppTheme.secondaryText),
                    SizedBox(width: 4),
                    Text(
                      'Free cancellation 24h before',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppTheme.secondaryText,
                      ),
                    ),
                    SizedBox(width: 12),
                    Icon(Icons.support_agent, size: 12, color: AppTheme.secondaryText),
                    SizedBox(width: 4),
                    Text(
                      '24/7 support',
                      style: TextStyle(
                        fontSize: 10,
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
    );
  }

  String _formatNextSlot(DateTime? nextSlot) {
    if (nextSlot == null) return 'Not available';
    
    final now = DateTime.now();
    final difference = nextSlot.difference(now);
    
    if (difference.inMinutes < 60) {
      return 'in ${difference.inMinutes} minutes';
    } else if (difference.inHours < 24) {
      return 'in ${difference.inHours} hours';
    } else {
      return '${nextSlot.day}/${nextSlot.month}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.buildSectionHeader('🎨 Authentic Experiences'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.moroccoGreen.withValues(alpha: 0.3)),
            ),
            child: const Row(
              children: [
                Icon(Icons.flash_on, color: AppTheme.moroccoGreen, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Real-time booking now available! Instant confirmation and flexible cancellation.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.moroccoGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ..._experiences.map((experience) => _buildEnhancedExperienceCard(experience)),
        ],
      ),
    );
  }
}
