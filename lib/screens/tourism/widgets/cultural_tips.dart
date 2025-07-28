import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';

class CulturalTips extends StatelessWidget {
  const CulturalTips({super.key});

  @override
  Widget build(BuildContext context) {
    final tips = [
      {'icon': '🧭', 'tip': 'Dress modestly for old medina visits'},
      {'icon': '🤝', 'tip': 'Use right hand for greetings and eating'},
      {'icon': '💬', 'tip': '"Inshallah" means "God willing" - common phrase'},
      {'icon': '🛒', 'tip': 'Bargaining is expected in souks and markets'},
      {'icon': '🕌', 'tip': 'Remove shoes before entering mosques'},
    ];

    return Column(
      children: tips
          .map((tip) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.tourismCategory.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: AppColors.tourismCategory.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    Text(tip['icon']!, style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        tip['tip']!,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
