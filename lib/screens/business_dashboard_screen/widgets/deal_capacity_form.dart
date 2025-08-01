import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

/// Deal capacity form with max customers settings
class DealCapacityForm extends StatelessWidget {
  final int maxCustomersPerDay;
  final int maxPerTimeSlot;
  final Function(int) onMaxCustomersChanged;
  final Function(int) onMaxPerSlotChanged;

  const DealCapacityForm({
    super.key,
    required this.maxCustomersPerDay,
    required this.maxPerTimeSlot,
    required this.onMaxCustomersChanged,
    required this.onMaxPerSlotChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('👥 Deal Capacity'),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Max customers per day:'),
                  Slider(
                    value: maxCustomersPerDay.toDouble(),
                    min: 5,
                    max: 50,
                    divisions: 9,
                    label: '$maxCustomersPerDay',
                    onChanged: (value) => onMaxCustomersChanged(value.round()),
                    activeColor: AppTheme.moroccoGreen,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Max per time slot:'),
                  Slider(
                    value: maxPerTimeSlot.toDouble(),
                    min: 2,
                    max: 20,
                    divisions: 9,
                    label: '$maxPerTimeSlot',
                    onChanged: (value) => onMaxPerSlotChanged(value.round()),
                    activeColor: AppTheme.moroccoGreen,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppTheme.moroccoGreen,
      ),
    );
  }
}