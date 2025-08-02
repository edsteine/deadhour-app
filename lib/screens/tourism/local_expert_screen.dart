import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/widgets/common/enhanced_app_bar.dart';

class LocalExpertScreen extends StatefulWidget {
  const LocalExpertScreen({super.key});

  @override
  State<LocalExpertScreen> createState() => _LocalExpertScreenState();
}

class _LocalExpertScreenState extends State<LocalExpertScreen> {
  String _selectedSpecialty = 'All';
  String _selectedCity = 'All Cities';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EnhancedAppBar(
        title: 'Local Experts',
        subtitle: 'Connect with Morocco\'s best guides',
        showBackButton: true,
        showGradient: true,
      ),
      body: Column(
        children: [
          _buildFilters(),
          Expanded(
            child: _buildExpertsList(),
          ),
        ],
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
              value: _selectedSpecialty,
              decoration: const InputDecoration(
                labelText: 'Specialty',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: [
                'All',
                'Historical Tours',
                'Cultural Experiences',
                'Adventure Guide',
                'Food Tours',
                'Shopping Guide'
              ]
                  .map((specialty) => DropdownMenuItem(
                      value: specialty, child: Text(specialty)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedSpecialty = value!;
                });
              },
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: _selectedCity,
              decoration: const InputDecoration(
                labelText: 'City',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: [
                'All Cities',
                'Marrakech',
                'Casablanca',
                'Fez',
                'Rabat',
                'Tangier'
              ]
                  .map((city) =>
                      DropdownMenuItem(value: city, child: Text(city)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCity = value!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpertsList() {
    final experts = [
      {
        'id': '1',
        'name': 'Ahmed Benali',
        'specialty': 'Historical Tours',
        'city': 'Marrakech',
        'rating': 4.9,
        'reviewCount': 127,
        'experience': '8 years',
        'languages': ['Arabic', 'French', 'English'],
        'image': 'https://i.pravatar.cc/150?img=1',
        'description':
            'Passionate historian specializing in Marrakech\'s rich heritage and hidden stories.',
        'pricePerHour': 150,
        'isVerified': true,
      },
      {
        'id': '2',
        'name': 'Fatima Zahra',
        'specialty': 'Cultural Experiences',
        'city': 'Fez',
        'rating': 4.8,
        'reviewCount': 89,
        'experience': '6 years',
        'languages': ['Arabic', 'French', 'English', 'Spanish'],
        'image': 'https://i.pravatar.cc/150?img=2',
        'description':
            'Cultural enthusiast offering authentic Moroccan experiences and traditional crafts.',
        'pricePerHour': 120,
        'isVerified': true,
      },
      {
        'id': '3',
        'name': 'Youssef Alami',
        'specialty': 'Adventure Guide',
        'city': 'Atlas Mountains',
        'rating': 4.7,
        'reviewCount': 156,
        'experience': '10 years',
        'languages': ['Arabic', 'French', 'English'],
        'image': 'https://i.pravatar.cc/150?img=3',
        'description':
            'Mountain guide with extensive knowledge of Atlas Mountains and Berber culture.',
        'pricePerHour': 200,
        'isVerified': true,
      },
      {
        'id': '4',
        'name': 'Laila Benali',
        'specialty': 'Food Tours',
        'city': 'Casablanca',
        'rating': 4.9,
        'reviewCount': 203,
        'experience': '5 years',
        'languages': ['Arabic', 'French', 'English'],
        'image': 'https://i.pravatar.cc/150?img=4',
        'description':
            'Culinary expert showcasing Morocco\'s diverse flavors and cooking traditions.',
        'pricePerHour': 180,
        'isVerified': true,
      },
      {
        'id': '5',
        'name': 'Omar Tazi',
        'specialty': 'Shopping Guide',
        'city': 'Marrakech',
        'rating': 4.6,
        'reviewCount': 78,
        'experience': '4 years',
        'languages': ['Arabic', 'French', 'English'],
        'image': 'https://i.pravatar.cc/150?img=5',
        'description':
            'Shopping specialist helping visitors find authentic Moroccan crafts and souvenirs.',
        'pricePerHour': 100,
        'isVerified': false,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      itemCount: experts.length,
      itemBuilder: (context, index) {
        return _buildExpertCard(experts[index]);
      },
    );
  }

  Widget _buildExpertCard(Map<String, dynamic> expert) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.md)),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(expert['image']),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            expert['name'],
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (expert['isVerified']) ...[
                            const SizedBox(width: AppSpacing.sm),
                            const Icon(
                              Icons.verified,
                              size: 16,
                              color: AppColors.success,
                            ),
                          ],
                        ],
                      ),
                      Text(
                        expert['specialty'],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.moroccoGreen,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Text(
                        '${expert['city']} • ${expert['experience']} experience',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star,
                            size: 16, color: AppColors.warning),
                        Text(
                          expert['rating'].toString(),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    Text(
                      '${expert['reviewCount']} reviews',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              expert['description'],
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                const Icon(Icons.language,
                    size: 16, color: AppTheme.secondaryText),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    expert['languages'].join(', '),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                Text(
                  '${expert['pricePerHour']} MAD/hour',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.moroccoGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _viewProfile(expert),
                    icon: const Icon(Icons.person),
                    label: const Text('View Profile'),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _contactExpert(expert),
                    icon: const Icon(Icons.message),
                    label: const Text('Contact'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _viewProfile(Map<String, dynamic> expert) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(expert['image']),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  expert['name'],
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                if (expert['isVerified']) ...[
                                  const SizedBox(width: AppSpacing.sm),
                                  const Icon(
                                    Icons.verified,
                                    size: 20,
                                    color: AppColors.success,
                                  ),
                                ],
                              ],
                            ),
                            Text(
                              expert['specialty'],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: AppTheme.moroccoGreen,
                                  ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    size: 16, color: AppColors.warning),
                                Text(
                                  '${expert['rating']} (${expert['reviewCount']} reviews)',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'About',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    expert['description'],
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'Experience & Languages',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      const Icon(Icons.work,
                          size: 16, color: AppTheme.secondaryText),
                      const SizedBox(width: AppSpacing.sm),
                      Text('${expert['experience']} of experience'),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      const Icon(Icons.language,
                          size: 16, color: AppTheme.secondaryText),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(expert['languages'].join(', ')),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'Pricing',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    '${expert['pricePerHour']} MAD per hour',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.moroccoGreen,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _contactExpert(expert);
                      },
                      child: const Text('Contact Expert'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _contactExpert(Map<String, dynamic> expert) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Contact ${expert['name']}'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Your Name',
                hintText: 'Enter your name',
              ),
            ),
            SizedBox(height: AppSpacing.md),
            TextField(
              decoration: InputDecoration(
                labelText: 'Message',
                hintText: 'Describe your tour requirements',
              ),
              maxLines: 3,
            ),
            SizedBox(height: AppSpacing.md),
            TextField(
              decoration: InputDecoration(
                labelText: 'Preferred Date',
                hintText: 'When would you like to book?',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Message sent to ${expert['name']}!'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Send Message'),
          ),
        ],
      ),
    );
  }
}
