import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/screens/cultural/state/application_state.dart';

class ApplicationActionButtons extends StatelessWidget {
  final ApplicationState applicationState;
  final VoidCallback onSubmit;

  const ApplicationActionButtons({
    super.key,
    required this.applicationState,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (applicationState.currentStep > 0)
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    applicationState.previousStep();
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: AppTheme.moroccoGreen),
                  ),
                  child: const Text(
                    'Previous',
                    style: TextStyle(color: AppTheme.moroccoGreen),
                  ),
                ),
              ),
            if (applicationState.currentStep > 0) const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: applicationState.isSubmitting ? null : _handleNextOrSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.moroccoGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: applicationState.isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        applicationState.currentStep == 3 ? 'Submit Application' : 'Next',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleNextOrSubmit() {
    if (applicationState.currentStep == 3) {
      onSubmit();
    } else {
      if (applicationState.validateCurrentStep()) {
        applicationState.nextStep();
      }
    }
  }
}