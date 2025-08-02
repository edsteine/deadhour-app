import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';

class CreateDealScheduleSection extends StatelessWidget {
  final List<String> selectedDays;
  final List<String> weekDays;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String targetItems;
  final int maxCustomersPerDay;
  final int maxPerTimeSlot;
  final Function(String, bool) onDaySelectionChanged;
  final VoidCallback onStartTimePressed;
  final VoidCallback onEndTimePressed;
  final ValueChanged<String> onTargetItemsChanged;
  final ValueChanged<int> onMaxCustomersChanged;
  final ValueChanged<int> onMaxPerTimeSlotChanged;

  const CreateDealScheduleSection({
    super.key,
    required this.selectedDays,
    required this.weekDays,
    required this.startTime,
    required this.endTime,
    required this.targetItems,
    required this.maxCustomersPerDay,
    required this.maxPerTimeSlot,
    required this.onDaySelectionChanged,
    required this.onStartTimePressed,
    required this.onEndTimePressed,
    required this.onTargetItemsChanged,
    required this.onMaxCustomersChanged,
    required this.onMaxPerTimeSlotChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('⏰ Dead Hours Schedule'),
        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: 0.05),
            border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Days:', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: weekDays.map((day) {
                  final isSelected = selectedDays.contains(day);
                  return FilterChip(
                    label: Text(day),
                    selected: isSelected,
                    onSelected: (selected) => onDaySelectionChanged(day, selected),
                    selectedColor: AppTheme.moroccoGreen.withValues(alpha: 0.2),
                    checkmarkColor: AppTheme.moroccoGreen,
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Start Time:', style: TextStyle(fontWeight: FontWeight.w600)),
                        InkWell(
                          onTap: onStartTimePressed,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(startTime.format(context)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('End Time:', style: TextStyle(fontWeight: FontWeight.w600)),
                        InkWell(
                          onTap: onEndTimePressed,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(endTime.format(context)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Duration: ${endTime.hour - startTime.hour} hours daily',
                style: const TextStyle(fontSize: 12, color: AppTheme.secondaryText),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Target Items Section
        _buildSectionHeader('🎯 Target Items'),
        const SizedBox(height: 12),

        RadioListTile<String>(
          title: const Text('All menu items'),
          value: 'all',
          groupValue: targetItems,
          onChanged: (value) => onTargetItemsChanged(value!),
          activeColor: AppTheme.moroccoGreen,
        ),
        RadioListTile<String>(
          title: const Text('Coffee & beverages only'),
          value: 'beverages',
          groupValue: targetItems,
          onChanged: (value) => onTargetItemsChanged(value!),
          activeColor: AppTheme.moroccoGreen,
        ),

        const SizedBox(height: 24),

        // Deal Capacity Section
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
                    onChanged: (value) => onMaxPerTimeSlotChanged(value.round()),
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