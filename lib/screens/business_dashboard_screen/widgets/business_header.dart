
import 'package:flutter/material.dart';
import 'package:deadhour/utils/mock_data.dart';
import 'package:deadhour/utils/app_theme.dart';

class BusinessHeader extends StatelessWidget {
  const BusinessHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final businessData = MockData.businessData;
    final venue = businessData['venue'];

    return ProfessionalGradientCard(
      colors: const [AppTheme.moroccoGreen, AppTheme.darkGreen],
      padding: const EdgeInsets.all(AppTheme.spacing20),
      margin: EdgeInsets.zero,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(AppTheme.radiusLarge),
        bottomRight: Radius.circular(AppTheme.radiusLarge),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    venue?.categoryIcon ?? '🏢',
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      venue?.name ?? 'Your Business',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Dead Hours → Revenue Solution',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 14,
                          color: Colors.white70,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            venue?.address ?? 'Location',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.moroccoGold.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'SOLVING',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildHeaderStat(
                  'Dead Hours Filled',
                  '68%',
                  Icons.schedule,
                ),
              ),
              Expanded(
                child: _buildHeaderStat(
                  'Revenue Saved',
                  '${businessData['monthlyStats']['platformRevenue']} MAD',
                  Icons.trending_up,
                ),
              ),
              Expanded(
                child: _buildHeaderStat(
                  'New Customers',
                  '${businessData['monthlyStats']['newCustomers']}',
                  Icons.people_alt,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildHeaderStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white70,
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
