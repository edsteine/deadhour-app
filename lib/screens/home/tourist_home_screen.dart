import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';
import '../../utils/mock_data.dart';
import '../../widgets/common/dead_hour_app_bar.dart';
import '../../models/deal.dart';
import '../../services/cultural_calendar_service.dart';

class TouristHomeScreen extends StatefulWidget {
  const TouristHomeScreen({super.key});

  @override
  State<TouristHomeScreen> createState() => _TouristHomeScreenState();
}

class _TouristHomeScreenState extends State<TouristHomeScreen> {
  final _culturalService = CulturalCalendarService();
  String _selectedCity = 'Casablanca';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeadHourAppBar(
        title: 'Discover Morocco',
        subtitle: 'Premium Tourist Experience',
        customActions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.amber),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                SizedBox(width: 4),
                Text(
                  'Premium',
                  style: TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          children: [
            _buildWelcomeSection(),
            const SizedBox(height: AppTheme.spacing24),
            _buildCulturalInsightsCard(),
            const SizedBox(height: AppTheme.spacing24),
            _buildLocationSelector(),
            const SizedBox(height: AppTheme.spacing24),
            _buildQuickActions(),
            const SizedBox(height: AppTheme.spacing24),
            _buildFeaturedExperiences(),
            const SizedBox(height: AppTheme.spacing24),
            _buildTrendingDeals(),
            const SizedBox(height: AppTheme.spacing24),
            _buildLocalExpertRecommendations(),
            const SizedBox(height: AppTheme.spacing24),
            _buildCulturalEvents(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.moroccoGreen,
            AppTheme.moroccoGreen.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.travel_explore,
                color: Colors.white,
                size: 32,
              ),
              const SizedBox(width: AppTheme.spacing12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome to Morocco',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Discover authentic experiences during off-peak hours',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),
          Row(
            children: [
              _buildWelcomeMetric('🏛️', 'Heritage Sites', '12'),
              const SizedBox(width: AppTheme.spacing16),
              _buildWelcomeMetric('🍽️', 'Local Cuisine', '50+'),
              const SizedBox(width: AppTheme.spacing16),
              _buildWelcomeMetric('💰', 'Avg. Savings', '35%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeMetric(String icon, String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacing12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        ),
        child: Column(
          children: [
            Text(
              icon,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: AppTheme.spacing4),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCulturalInsightsCard() {
    final currentTime = DateTime.now();
    final prayerTimes = _culturalService.getTodaysPrayerTimes();
    const nextPrayer = 'Maghrib at 18:30';
    final isRamadan = _culturalService.isRamadan();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.mosque,
                  color: AppTheme.moroccoGreen,
                  size: 24,
                ),
                SizedBox(width: AppTheme.spacing12),
                Text(
                  'Cultural Context',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            if (isRamadan)
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing12),
                decoration: BoxDecoration(
                  color: Colors.purple.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                  border: Border.all(color: Colors.purple.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.nightlight_round, color: Colors.purple),
                    const SizedBox(width: AppTheme.spacing12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ramadan Period',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Special schedules and experiences available',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            
            const SizedBox(height: AppTheme.spacing12),
            
            // Prayer times
            const Row(
              children: [
                Icon(Icons.access_time, color: Colors.grey),
                SizedBox(width: AppTheme.spacing8),
                Text(
                  'Next Prayer: $nextPrayer',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppTheme.spacing12),
            
            // Cultural tip
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing12),
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: AppTheme.moroccoGreen),
                  SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: Text(
                      'Tip: Many venues offer special tourist discounts during prayer times',
                      style: TextStyle(
                        color: AppTheme.moroccoGreen,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSelector() {
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
              final isSelected = city == _selectedCity;
              
              return Padding(
                padding: const EdgeInsets.only(right: AppTheme.spacing8),
                child: FilterChip(
                  label: Text(city),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCity = city;
                    });
                  },
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

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppTheme.spacing12),
        Row(
          children: [
            Expanded(
              child: _buildQuickActionCard(
                'Find Deals',
                Icons.local_offer,
                Colors.orange,
                () => context.push('/deals'),
              ),
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: _buildQuickActionCard(
                'Local Experts',
                Icons.person_pin,
                Colors.blue,
                () => context.push('/local-expert'),
              ),
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: _buildQuickActionCard(
                'Community',
                Icons.people,
                AppTheme.moroccoGreen,
                () => context.go('/community'),
              ),
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: _buildQuickActionCard(
                'Venues',
                Icons.place,
                Colors.purple,
                () => context.push('/venues'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedExperiences() {
    final experiences = [
      {
        'title': 'Traditional Hammam Experience',
        'subtitle': 'Royal Spa, Marrakech',
        'discount': '40% OFF',
        'image': 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
        'originalPrice': 200.0,
        'discountedPrice': 120.0,
        'rating': 4.8,
        'category': 'Wellness',
      },
      {
        'title': 'Authentic Tagine Cooking Class',
        'subtitle': 'Chef Hassan\'s Kitchen, Fez',
        'discount': '30% OFF',
        'image': 'https://images.unsplash.com/photo-1534939561126-855b8675edd7?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
        'originalPrice': 150.0,
        'discountedPrice': 105.0,
        'rating': 4.9,
        'category': 'Culinary',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Featured Experiences',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () => context.push('/venues'),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacing12),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: experiences.length,
            itemBuilder: (context, index) {
              final experience = experiences[index];
              return Padding(
                padding: const EdgeInsets.only(right: AppTheme.spacing16),
                child: _buildExperienceCard(experience),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildExperienceCard(Map<String, dynamic> experience) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Card(
        margin: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(AppTheme.radiusMedium)),
              child: Stack(
                children: [
                  Image.network(
                    experience['image'],
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 120,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image, size: 50),
                      );
                    },
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        experience['discount'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacing12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    experience['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    experience['subtitle'],
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppTheme.spacing8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        experience['rating'].toString(),
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      Text(
                        '${experience['discountedPrice']} MAD',
                        style: const TextStyle(
                          color: AppTheme.moroccoGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingDeals() {
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

  Widget _buildLocalExpertRecommendations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Local Expert Recommendations',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () => context.push('/local-expert'),
              child: const Text('Find Experts'),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacing12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacing16),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppTheme.moroccoGreen.withValues(alpha: 0.2),
                      child: const Icon(
                        Icons.person,
                        color: AppTheme.moroccoGreen,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacing16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Aisha - Cultural Guide',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Certified guide specializing in Moroccan traditions',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacing4),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 16),
                              const SizedBox(width: 4),
                              const Text('4.9'),
                              const SizedBox(width: AppTheme.spacing8),
                              Icon(Icons.translate, size: 16, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text(
                                'Arabic, French, English',
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
                  ],
                ),
                const SizedBox(height: AppTheme.spacing16),
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacing12),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.tips_and_updates, color: Colors.blue),
                      const SizedBox(width: AppTheme.spacing12),
                      Expanded(
                        child: Text(
                          '"Visit the traditional markets early morning for the best prices and authentic experience."',
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCulturalEvents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cultural Events & Festivals',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppTheme.spacing12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacing16),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppTheme.spacing12),
                      decoration: BoxDecoration(
                        color: Colors.purple.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                      ),
                      child: const Icon(
                        Icons.celebration,
                        color: Colors.purple,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacing16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Marrakech Arts Festival',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Traditional music and dance performances',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacing4),
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text(
                                'This Weekend',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: AppTheme.spacing12),
                              Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text(
                                'Jemaa el-Fnaa',
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
                  ],
                ),
                const SizedBox(height: AppTheme.spacing12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => context.push('/tourism'),
                    child: const Text('Explore Cultural Events'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _refreshData() async {
    // Simulate data refresh
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // Refresh state if needed
    });
  }
}