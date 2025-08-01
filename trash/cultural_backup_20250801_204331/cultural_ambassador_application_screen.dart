import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/app_theme.dart';

// Import modular application widgets
import 'widgets/application_progress_widget.dart';
import 'widgets/application_personal_info_step.dart';
import 'widgets/application_expertise_step.dart';
import 'widgets/application_experience_step.dart';
import 'widgets/application_review_step.dart';
import 'widgets/application_action_buttons.dart';
import 'application_state.dart';

class CulturalAmbassadorApplicationScreen extends StatefulWidget {
  const CulturalAmbassadorApplicationScreen({super.key});

  @override
  State<CulturalAmbassadorApplicationScreen> createState() =>
      _CulturalAmbassadorApplicationScreenState();
}

class _CulturalAmbassadorApplicationScreenState
    extends State<CulturalAmbassadorApplicationScreen>
    with TickerProviderStateMixin {
  
  late ApplicationState _applicationState;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _applicationState = ApplicationState();
  }

  @override
  void dispose() {
    _applicationState.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onStepChanged(int step) {
    setState(() {
      _applicationState.currentStep = step;
    });
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onNext() {
    if (_applicationState.currentStep < 3) {
      _onStepChanged(_applicationState.currentStep + 1);
    }
  }

  void _onPrevious() {
    if (_applicationState.currentStep > 0) {
      _onStepChanged(_applicationState.currentStep - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cultural Ambassador Application'),
        backgroundColor: AppTheme.moroccoGreen,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          ApplicationProgressWidget(
            currentStep: _applicationState.currentStep,
            onStepTapped: _onStepChanged,
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _applicationState.currentStep = index;
                });
              },
              children: [
                ApplicationPersonalInfoStep(state: _applicationState),
                ApplicationExpertiseStep(state: _applicationState),
                ApplicationExperienceStep(state: _applicationState),
                ApplicationReviewStep(state: _applicationState),
              ],
            ),
          ),
          ApplicationActionButtons(
            currentStep: _applicationState.currentStep,
            isSubmitting: _applicationState.isSubmitting,
            onNext: _onNext,
            onPrevious: _onPrevious,
            onSubmit: () => _applicationState.submitApplication(context),
          ),
        ],
      ),
    );
  }
}