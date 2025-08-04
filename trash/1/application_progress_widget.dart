import 'package:flutter/material.dart';
import '../../../utils/theme.dart';

/// Progress indicator widget for application steps
class ApplicationProgressWidget extends StatelessWidget {
  final int currentStep;
  final Function(int) onStepTapped;

  const ApplicationProgressWidget({
    super.key,
    required this.currentStep,
    required this.onStepTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
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
              Text(
                'Step ${currentStep + 1} of 4',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${((currentStep + 1) / 4 * 100).toInt()}% Complete',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.secondaryText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: (currentStep + 1) / 4,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.moroccoGreen),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStepIndicator(0, 'Personal', Icons.person),
              _buildStepIndicator(1, 'Expertise', Icons.star),
              _buildStepIndicator(2, 'Experience', Icons.history_edu),
              _buildStepIndicator(3, 'Review', Icons.check_circle),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(int step, String label, IconData icon) {
    final isActive = step == currentStep;
    final isCompleted = step < currentStep;
    
    return GestureDetector(
      onTap: () => onStepTapped(step),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isCompleted
                  ? AppTheme.moroccoGreen
                  : isActive
                      ? AppTheme.moroccoGreen.withValues(alpha: 0.2)
                      : Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCompleted ? Icons.check : icon,
              color: isCompleted
                  ? Colors.white
                  : isActive
                      ? AppTheme.moroccoGreen
                      : Colors.grey.shade400,
              size: 20,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? AppTheme.moroccoGreen : AppTheme.secondaryText,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}