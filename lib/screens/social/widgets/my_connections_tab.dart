import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/screens/social/widgets/network_stat.dart';
import 'package:deadhour/screens/social/widgets/connection_card.dart';
import 'package:deadhour/screens/social/widgets/upcoming_experience_card.dart';

class MyConnectionsTab extends StatelessWidget {
  final Function(Map<String, dynamic>) onViewExperienceDetails;
  final Function(String) onMessageConnection;

  const MyConnectionsTab({
    super.key,
    required this.onViewExperienceDetails,
    required this.onMessageConnection,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Connection Stats
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.moroccoGreen, AppTheme.moroccoGold],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Social Network',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: NetworkStat(value: '23', label: 'Connections', icon: Icons.people),
                    ),
                    Expanded(
                      child: NetworkStat(value: '8', label: 'Experiences', icon: Icons.explore),
                    ),
                    Expanded(
                      child: NetworkStat(value: '4.9', label: 'Rating', icon: Icons.star),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Recent Connections
          const Text(
            'Recent Connections',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          ConnectionCard(name: 'Sarah Expat', role: 'Rooftop Social Host', rating: 4.8, connection: 'Connected after joining sunset experience', onMessageConnection: onMessageConnection),
          ConnectionCard(name: 'Hassan Guide', role: 'Cultural Expert', rating: 4.9, connection: 'Coffee culture experience leader', onMessageConnection: onMessageConnection),
          ConnectionCard(name: 'Omar Mountain', role: 'Adventure Guide', rating: 4.7, connection: 'Atlas Mountains hiking guide', onMessageConnection: onMessageConnection),

          const SizedBox(height: 24),

          // Upcoming Experiences
          const Text(
            'Your Upcoming Experiences',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          UpcomingExperienceCard(title: 'Traditional Hammam', dateTime: 'Saturday 14:00', location: 'Fez Medina', price: 250, onViewDetails: () => onViewExperienceDetails({})),
          UpcomingExperienceCard(title: 'Atlas Day Trip', dateTime: 'Sunday 07:00', location: 'Imlil Village', price: 380, onViewDetails: () => onViewExperienceDetails({})),
        ],
      ),
    );
  }
}