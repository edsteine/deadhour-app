import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';
import '../../utils/constants.dart';
import '../../widgets/common/enhanced_app_bar.dart';

class TourismScreen extends StatefulWidget {
  const TourismScreen({super.key});

  @override
  State<TourismScreen> createState() => _TourismScreenState();
}

class _TourismScreenState extends State<TourismScreen> {
  String _selectedCity = 'All Cities';
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EnhancedAppBar(
        title: 'Tourism & Culture',
        subtitle: 'Discover Morocco\'s hidden gems',
        showGradient: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilters(),
            _buildFeaturedSection(),
            _buildCategoriesSection(),
            _buildLocalExpertsSection(),
            _buildPopularDestinationsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              value: _selectedCity,
              decoration: const InputDecoration(
                labelText: 'City',
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: ['All Cities', 'Marrakech', 'Casablanca', 'Fez', 'Rabat', 'Tangier']
                  .map((city) => DropdownMenuItem(value: city, child: Text(city)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCity = value!;
                });
              },
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: ['All', 'Historical', 'Cultural', 'Adventure', 'Food Tours', 'Shopping']
                  .map((category) => DropdownMenuItem(value: category, child: Text(category)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            'Featured Experiences',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            itemCount: 5,
            itemBuilder: (context, index) {
              return _buildFeaturedCard(index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedCard(int index) {
    final experiences = [
      {
        'title': 'Marrakech Medina Tour',
        'subtitle': 'Historical Walking Tour',
        'price': '150 MAD',
        'image': 'https://picsum.photos/400/300?random=1',
        'rating': 4.8,
      },
      {
        'title': 'Atlas Mountains Hike',
        'subtitle': 'Adventure Experience',
        'price': '300 MAD',
        'image': 'https://picsum.photos/400/300?random=2',
        'rating': 4.9,
      },
      {
        'title': 'Fez Pottery Workshop',
        'subtitle': 'Cultural Experience',
        'price': '120 MAD',
        'image': 'https://picsum.photos/400/300?random=3',
        'rating': 4.7,
      },
      {
        'title': 'Casablanca Food Tour',
        'subtitle': 'Culinary Adventure',
        'price': '200 MAD',
        'image': 'https://images.unsplash.com/photo-1551218808-94e220e084d2?w=400',
        'rating': 4.6,
      },
      {
        'title': 'Essaouira Beach Day',
        'subtitle': 'Coastal Experience',
        'price': '250 MAD',
        'image': 'https://images.unsplash.com/photo-1570197788417-0e82375c9371?w=400',
        'rating': 4.5,
      },
    ];

    final experience = experiences[index];

    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: AppSpacing.md),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppBorderRadius.md)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(AppBorderRadius.md)),
              child: Image.network(
                experience['image'] as String,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    experience['title'] as String,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    experience['subtitle'] as String,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        experience['price'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.moroccoGreen,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: AppColors.warning),
                          Text(
                            experience['rating'].toString(),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
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

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.lg),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            'Browse by Category',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            itemCount: 6,
            itemBuilder: (context, index) {
              return _buildCategoryCard(index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(int index) {
    final categories = [
      {'name': 'Historical', 'icon': '🏛️', 'color': AppColors.tourismCategory},
      {'name': 'Cultural', 'icon': '🎭', 'color': AppColors.entertainmentCategory},
      {'name': 'Adventure', 'icon': '🏔️', 'color': AppColors.sportsCategory},
      {'name': 'Food Tours', 'icon': '🍽️', 'color': AppColors.foodCategory},
      {'name': 'Shopping', 'icon': '🛍️', 'color': AppColors.familyCategory},
      {'name': 'Nature', 'icon': '🌿', 'color': AppColors.wellnessCategory},
    ];

    final category = categories[index];

    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: AppSpacing.md),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: (category['color'] as Color).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppBorderRadius.md),
            ),
            child: Center(
              child: Text(
                category['icon'] as String,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            category['name'] as String,
            style: Theme.of(context).textTheme.labelSmall,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildLocalExpertsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.lg),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Local Experts',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextButton(
                onPressed: () => context.push('/tourism/local-expert'),
                child: const Text('View All'),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            itemCount: 4,
            itemBuilder: (context, index) {
              return _buildExpertCard(index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildExpertCard(int index) {
    final experts = [
      {
        'name': 'Ahmed Benali',
        'specialty': 'Historical Tours',
        'rating': 4.9,
        'image': 'https://i.pravatar.cc/150?img=1',
      },
      {
        'name': 'Fatima Zahra',
        'specialty': 'Cultural Experiences',
        'rating': 4.8,
        'image': 'https://i.pravatar.cc/150?img=2',
      },
      {
        'name': 'Youssef Alami',
        'specialty': 'Adventure Guide',
        'rating': 4.7,
        'image': 'https://i.pravatar.cc/150?img=3',
      },
      {
        'name': 'Laila Benali',
        'specialty': 'Food Tours',
        'rating': 4.9,
        'image': 'https://i.pravatar.cc/150?img=4',
      },
    ];

    final expert = experts[index];

    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: AppSpacing.md),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(expert['image'] as String),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            expert['name'] as String,
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            expert['specialty'] as String,
            style: Theme.of(context).textTheme.labelSmall,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, size: 12, color: AppColors.warning),
              Text(
                expert['rating'].toString(),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPopularDestinationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.lg),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            'Popular Destinations',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          itemCount: 3,
          itemBuilder: (context, index) {
            return _buildDestinationCard(index);
          },
        ),
        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }

  Widget _buildDestinationCard(int index) {
    final destinations = [
      {
        'name': 'Jemaa el-Fnaa',
        'city': 'Marrakech',
        'description': 'The heart of Marrakech with traditional performances and food stalls',
        'image': 'https://picsum.photos/400/300?random=1',
        'experiences': 12,
      },
      {
        'name': 'Hassan II Mosque',
        'city': 'Casablanca',
        'description': 'One of the largest mosques in the world with stunning architecture',
        'image': 'https://picsum.photos/400/300?random=2',
        'experiences': 8,
      },
      {
        'name': 'Fez Medina',
        'city': 'Fez',
        'description': 'UNESCO World Heritage site with traditional crafts and culture',
        'image': 'https://picsum.photos/400/300?random=3',
        'experiences': 15,
      },
    ];

    final destination = destinations[index];

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppBorderRadius.md)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(AppBorderRadius.md)),
            child: Image.network(
              destination['image'] as String,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        destination['name'] as String,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Chip(
                      label: Text('${destination['experiences']} experiences'),
                      backgroundColor: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                      labelStyle: const TextStyle(
                        color: AppTheme.moroccoGreen,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                Text(
                  destination['city'] as String,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.moroccoGreen,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  destination['description'] as String,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

