import 'package:flutter/material.dart';

class LocalExpertsTab extends StatelessWidget {
  final Function(String) buildSectionHeader;
  final Function(Map<String, String>) buildExpertCard;
  final List<Map<String, String>> experts;

  const LocalExpertsTab({
    super.key,
    required this.buildSectionHeader,
    required this.buildExpertCard,
    required this.experts,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionHeader('🌟 Available Local Experts'),
          const SizedBox(height: 12),

          ...experts.map((expert) => buildExpertCard(expert)),
        ],
      ),
    );
  }
}
