import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/performance_utils.dart';
import '../../utils/app_error_handler.dart';
import 'widgets/application_success_dialog.dart';

/// Application state management for Cultural Ambassador application
class ApplicationState {
  // Form controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final experienceController = TextEditingController();
  final languagesController = TextEditingController();
  final aboutController = TextEditingController();
  final motivationController = TextEditingController();

  // Application state
  bool isSubmitting = false;
  int currentStep = 0;

  // Selections
  final List<String> selectedExpertise = [];
  final List<String> selectedLanguages = [];
  final List<String> availabilityDays = [];

  // Static data
  final List<Map<String, dynamic>> culturalExpertise = [
    {'id': 'traditional_cuisine', 'name': 'Traditional Cuisine', 'icon': '🍽️'},
    {'id': 'historical_sites', 'name': 'Historical Sites', 'icon': '🏛️'},
    {'id': 'local_arts', 'name': 'Local Arts & Crafts', 'icon': '🎨'},
    {'id': 'music_dance', 'name': 'Music & Dance', 'icon': '🎵'},
    {'id': 'religious_culture', 'name': 'Religious Culture', 'icon': '🕌'},
    {'id': 'berber_culture', 'name': 'Berber Culture', 'icon': '🏔️'},
    {'id': 'market_souks', 'name': 'Markets & Souks', 'icon': '🛒'},
    {'id': 'desert_experiences', 'name': 'Desert Experiences', 'icon': '🐪'},
  ];

  final List<String> moroccanLanguages = [
    'Arabic',
    'Berber/Tamazight',
    'French',
    'English',
    'Spanish',
    'German',
    'Italian',
    'Dutch'
  ];

  final List<String> weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cityController.dispose();
    experienceController.dispose();
    languagesController.dispose();
    aboutController.dispose();
    motivationController.dispose();
  }

  bool validateCurrentStep() {
    // For MVP implementation, skip validation - this is a future feature placeholder
    return true;
  }

  Future<void> submitApplication(BuildContext context) async {
    if (!context.mounted) return;
    
    isSubmitting = true;

    try {
      PerformanceUtils.hapticFeedback(HapticFeedbackType.medium);

      // Simulate application submission
      await Future.delayed(const Duration(seconds: 2));

      if (context.mounted) {
        _showSubmissionSuccess(context);
      }
    } catch (error) {
      if (context.mounted) {
        final appError = AppErrorHandler.parseError(error);
        AppErrorHandler.showErrorSnackbar(context, appError,
            onRetry: () => submitApplication(context));
      }
    } finally {
      isSubmitting = false;
    }
  }

  void _showSubmissionSuccess(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => ApplicationSuccessDialog(
        onDone: () {
          context.pop(); // Close success sheet
          context.pop(); // Close application screen
        },
      ),
    );
  }
}