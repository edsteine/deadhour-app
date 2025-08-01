import 'package:deadhour/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

/// Deal schedule form with days, time range, and target items
class DealScheduleForm extends StatelessWidget {
  final List<String> selectedDays;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String targetItems;
  final Function(List<String>) onDaysChanged;
  final Function(TimeOfDay) onStartTimeChanged;
  final Function(TimeOfDay) onEndTimeChanged;
  final Function(String) onTargetItemsChanged;

  const DealScheduleForm({
    super.key,
    required this.selectedDays,
    required this.startTime,
    required this.endTime,
    required this.targetItems,
    required this.onDaysChanged,
    required this.onStartTimeChanged,
    required this.onEndTimeChanged,
    required this.onTargetItemsChanged,
  });

  final List<String> _weekDays = const [
    'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'
  ];

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
            border: Border.all(
                color: AppColors.error.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Days:',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _weekDays.map((day) {
                  final isSelected = selectedDays.contains(day);
                  return FilterChip(
                    label: Text(day),
                    selected: isSelected,
                    onSelected: (selected) {
                      final updatedDays = List<String>.from(selectedDays);
                      if (selected) {
                        updatedDays.add(day);
                      } else {
                        updatedDays.remove(day);
                      }
                      onDaysChanged(updatedDays);
                    },
                    selectedColor: AppTheme.moroccoGreen
                        .withValues(alpha: 0.2),
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
                        const Text('Start Time:',
                            style: TextStyle(
                                fontWeight: FontWeight.w600)),
                        InkWell(
                          onTap: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: startTime,
                            );
                            if (time != null) {
                              onStartTimeChanged(time);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade300),
                              borderRadius:
                                  BorderRadius.circular(8),
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
                        const Text('End Time:',
                            style: TextStyle(
                                fontWeight: FontWeight.w600)),
                        InkWell(
                          onTap: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: endTime,
                            );
                            if (time != null) {
                              onEndTimeChanged(time);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade300),
                              borderRadius:
                                  BorderRadius.circular(8),
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
                style: const TextStyle(
                    fontSize: 12, color: AppTheme.secondaryText),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
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