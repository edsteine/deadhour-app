import 'package:flutter/material.dart';

class CulturalTab extends StatelessWidget {
  final Function() buildCulturalDashboard;
  final Function(String) buildSectionHeader;
  final Function() buildCulturalEvents;
  final Function() buildCulturalTips;

  const CulturalTab({
    super.key,
    required this.buildCulturalDashboard,
    required this.buildSectionHeader,
    required this.buildCulturalEvents,
    required this.buildCulturalTips,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cultural integration dashboard
          buildCulturalDashboard(),
          
          const SizedBox(height: 24),
          
          buildSectionHeader('📅 Cultural Calendar'),
          const SizedBox(height: 12),
          buildCulturalEvents(),
          
          const SizedBox(height: 24),
          
          buildSectionHeader('🧭 Cultural Tips'),
          const SizedBox(height: 12),
          buildCulturalTips(),
        ],
      ),
    );
  }
}
