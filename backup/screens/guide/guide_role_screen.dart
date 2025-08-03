import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../widgets/common/enhanced_app_bar.dart';

class GuideRoleScreen extends StatefulWidget {
  const GuideRoleScreen({super.key});

  @override
  State<GuideRoleScreen> createState() => _GuideRoleScreenState();
}

class _GuideRoleScreenState extends State<GuideRoleScreen> {
  String _selectedSpecialty = 'All';
  String _selectedCity = 'All Cities';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EnhancedAppBar(
        title: 'Guide Role',
        subtitle: 'Local expertise and cultural experiences - €20/month',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ADDON Benefits Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withValues(alpha: 0.8)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.tour, color: Colors.white, size: 32),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Guide Role Active',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '€20/month - Cultural & Experience Expertise',
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
                  const SizedBox(height: 16),
                  const Text(
                    'Cross-Role Amplification: Combine with Business Role for €50/month total revenue potential',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Filter Section
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedSpecialty,
                    decoration: const InputDecoration(
                      labelText: 'Guide Specialty',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                          value: 'All', child: Text('All Specialties')),
                      DropdownMenuItem(
                          value: 'Cultural', child: Text('Cultural Tours')),
                      DropdownMenuItem(
                          value: 'Food', child: Text('Food Experiences')),
                      DropdownMenuItem(
                          value: 'Historical', child: Text('Historical Sites')),
                      DropdownMenuItem(
                          value: 'Adventure',
                          child: Text('Adventure Activities')),
                      DropdownMenuItem(
                          value: 'Shopping', child: Text('Shopping & Souks')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedSpecialty = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedCity,
                    decoration: const InputDecoration(
                      labelText: 'City',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                          value: 'All Cities', child: Text('All Cities')),
                      DropdownMenuItem(
                          value: 'Casablanca', child: Text('Casablanca')),
                      DropdownMenuItem(
                          value: 'Marrakech', child: Text('Marrakech')),
                      DropdownMenuItem(value: 'Rabat', child: Text('Rabat')),
                      DropdownMenuItem(value: 'Fez', child: Text('Fez')),
                      DropdownMenuItem(
                          value: 'Tangier', child: Text('Tangier')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedCity = value!;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Guide Opportunities Section
            const Text(
              'Available Guide Opportunities',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Sample Guide Opportunities
            ..._buildGuideOpportunities(),

            const SizedBox(height: 24),

            // Guide Metrics Dashboard
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Guide Performance',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child:
                            _buildMetricCard('Rating', '4.8⭐', Colors.orange),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child:
                            _buildMetricCard('Tours', '47', AppColors.primary),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child:
                            _buildMetricCard('Revenue', '€840', Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'guideCreateExperienceFAB',
        onPressed: () {
          // Navigate to create guide experience
        },
        label: const Text('Create Experience'),
        icon: const Icon(Icons.add_location_alt),
      ),
    );
  }

  List<Widget> _buildGuideOpportunities() {
    return [
      _buildGuideOpportunityCard(
        'Hassan II Mosque Cultural Tour',
        'Historical & Religious Sites',
        '€25/person',
        '2 hours',
        'Available today 14:00-16:00',
        Icons.mosque,
      ),
      _buildGuideOpportunityCard(
        'Casablanca Food Discovery Walk',
        'Food & Local Cuisine',
        '€30/person',
        '3 hours',
        'Available tomorrow 18:00-21:00',
        Icons.restaurant,
      ),
      _buildGuideOpportunityCard(
        'Marrakech Souk Navigation',
        'Shopping & Culture',
        '€20/person',
        '2.5 hours',
        'Available weekend',
        Icons.shopping_bag,
      ),
    ];
  }

  Widget _buildGuideOpportunityCard(
    String title,
    String category,
    String price,
    String duration,
    String availability,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      duration,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  availability,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              // Accept guide opportunity
            },
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
