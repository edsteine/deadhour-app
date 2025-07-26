import 'package:flutter/material.dart';

class ExperiencesTab extends StatelessWidget {
  final Function(String) buildSectionHeader;
  final Function(Map<String, String>) buildExperienceCard;

  final List<Map<String, String>> _experiences = [
    {
      'title': '🏺 Traditional Pottery Workshop',
      'description': 'Learn from master craftsmen in Fez medina',
      'price': '2 hours • 45€ • English/French',
      'icon': 'Icons.handyman',
      'color': 'Colors.orange',
    },
    {
      'title': '🍽️ Home Cooking with Local Family',
      'description': 'Cook tagine and couscous in authentic setting',
      'price': '3 hours • 35€ • All languages',
      'icon': 'Icons.home',
      'color': 'Colors.green',
    },
    {
      'title': '🕌 Spiritual Journey & Prayer Experience',
      'description': 'Respectful mosque visit with cultural guide',
      'price': '90 min • 25€ • Modest dress required',
      'icon': 'Icons.mosque',
      'color': 'Colors.blue',
    },
    {
      'title': '🛒 Souk Navigation Masterclass',
      'description': 'Bargaining secrets and hidden shop discoveries',
      'price': '2 hours • 30€ • Small groups only',
      'icon': 'Icons.shopping_bag',
      'color': 'Colors.purple',
    },
  ];

  ExperiencesTab({
    super.key,
    required this.buildSectionHeader,
    required this.buildExperienceCard,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionHeader('🎨 Authentic Experiences'),
          const SizedBox(height: 12),
          ..._experiences.map((experience) => buildExperienceCard(experience)).toList(),
        ],
      ),
    );
  }
}
