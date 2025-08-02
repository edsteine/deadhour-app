import 'package:flutter/material.dart';

class AnalyticsFeedbackWidget extends StatelessWidget {
  const AnalyticsFeedbackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Overall Rating',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  const Text('4.6', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 4),
                  ...List.generate(5, (index) => Icon(
                    index < 4 ? Icons.star : Icons.star_half,
                    color: Colors.amber,
                    size: 16,
                  )),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            '"Great deals during off-peak hours! The service is excellent and prices are very reasonable."',
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}