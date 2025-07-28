import 'package:flutter/material.dart';
import 'package:deadhour/providers/role_toggle_provider.dart';
import 'package:deadhour/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalExpertsTab extends ConsumerWidget {
  final Function(String) buildSectionHeader;
  final Function() buildPremiumUpgradeCard;
  final Function(Map<String, String>) buildExpertCard;
  final List<Map<String, String>> experts;

  const LocalExpertsTab({
    super.key,
    required this.buildSectionHeader,
    required this.buildPremiumUpgradeCard,
    required this.buildExpertCard,
    required this.experts,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPremiumUser = ref.watch(roleToggleProvider) == UserRole.premium;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Expert matching section
          if (!isPremiumUser) ...[
            buildPremiumUpgradeCard(),
            const SizedBox(height: 16),
          ],

          buildSectionHeader('🌟 Available Local Experts'),
          const SizedBox(height: 12),

          ...experts.map((expert) => buildExpertCard(expert)),
        ],
      ),
    );
  }
}
