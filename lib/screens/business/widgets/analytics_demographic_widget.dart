import 'package:flutter/material.dart';

class AnalyticsDemographicWidget extends StatelessWidget {
  const AnalyticsDemographicWidget({super.key});

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
          _buildDemographicRow('Locals', '68%', Colors.blue),
          _buildDemographicRow('Tourists', '32%', Colors.green),
          const SizedBox(height: 16),
          _buildDemographicRow('Age 18-25', '24%', Colors.purple),
          _buildDemographicRow('Age 26-35', '45%', Colors.orange),
          _buildDemographicRow('Age 36+', '31%', Colors.red),
        ],
      ),
    );
  }

  Widget _buildDemographicRow(String category, String percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(category),
            ],
          ),
          Text(
            percentage,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}