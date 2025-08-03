import 'package:flutter/material.dart';
import '../../../utils/theme.dart';
import '../../../utils/performance_utils.dart';
import '../state/application_state.dart';

class ExpertiseStep extends StatelessWidget {
  final ApplicationState applicationState;

  const ExpertiseStep({
    super.key,
    required this.applicationState,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cultural Expertise',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Select the areas of Moroccan culture you\'re most knowledgeable about.',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.secondaryText,
            ),
          ),
          const SizedBox(height: 24),

          // Cultural Expertise Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
            itemCount: applicationState.culturalExpertise.length,
            itemBuilder: (context, index) {
              final expertise = applicationState.culturalExpertise[index];
              final isSelected = applicationState.selectedExpertise.contains(expertise['id']);
              
              return InkWell(
                onTap: () {
                  applicationState.toggleExpertise(expertise['id'] as String);
                  PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
                },
                borderRadius: BorderRadius.circular(12),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.moroccoGreen.withValues(alpha: 0.1)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.moroccoGreen
                          : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        expertise['icon'] as String,
                        style: const TextStyle(fontSize: 32),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        expertise['name'] as String,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? AppTheme.moroccoGreen
                              : AppTheme.primaryText,
                        ),
                      ),
                      if (isSelected)
                        const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Icon(
                            Icons.check_circle,
                            color: AppTheme.moroccoGreen,
                            size: 16,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),

          // Availability
          const Text(
            'Availability',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'When are you typically available to guide visitors?',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.secondaryText,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: applicationState.weekDays.map((day) {
              final isSelected = applicationState.availabilityDays.contains(day);
              return FilterChip(
                selected: isSelected,
                label: Text(day),
                onSelected: (selected) {
                  applicationState.toggleAvailabilityDay(day);
                },
                selectedColor: AppTheme.moroccoGreen.withValues(alpha: 0.2),
                checkmarkColor: AppTheme.moroccoGreen,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}