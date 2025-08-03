import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';
import '../../utils/performance_utils.dart';
import '../../utils/error_utils.dart';
import 'state/application_state.dart';
import 'widgets/progress_indicator_widget.dart';
import 'widgets/personal_info_step.dart';
import 'widgets/expertise_step.dart';
import 'widgets/experience_step.dart';
import 'widgets/review_step.dart';
import 'widgets/application_action_buttons.dart';
import 'widgets/submission_success_dialog.dart';

class CulturalAmbassadorApplicationScreen extends StatefulWidget {
  const CulturalAmbassadorApplicationScreen({super.key});

  @override
  State<CulturalAmbassadorApplicationScreen> createState() =>
      _CulturalAmbassadorApplicationScreenState();
}

class _CulturalAmbassadorApplicationScreenState
    extends State<CulturalAmbassadorApplicationScreen> {
  late ApplicationState _applicationState;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _applicationState = ApplicationState();
    _applicationState.addListener(_onStateChanged);
  }

  @override
  void dispose() {
    _applicationState.removeListener(_onStateChanged);
    _applicationState.dispose();
    super.dispose();
  }

  void _onStateChanged() {
    if (mounted) {
      setState(() {});
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
          ProgressIndicatorWidget(currentStep: _applicationState.currentStep),
          Expanded(
            child: _buildApplicationForm(),
          ),
          ApplicationActionButtons(
            applicationState: _applicationState,
            onSubmit: _submitApplication,
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationForm() {
    return Form(
      key: _formKey,
      child: PageView(
        controller: PageController(initialPage: _applicationState.currentStep),
        onPageChanged: (index) {
          _applicationState.currentStep = index;
        },
        children: [
          PersonalInfoStep(applicationState: _applicationState),
          ExpertiseStep(applicationState: _applicationState),
          ExperienceStep(applicationState: _applicationState),
          ReviewStep(applicationState: _applicationState),
        ],
      ),
    );
  }

  Future<void> _submitApplication() async {
    _applicationState.isSubmitting = true;

    try {
      PerformanceUtils.hapticFeedback(HapticFeedbackType.medium);

      // Simulate application submission
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        SubmissionSuccessDialog.show(context);
      }
    } catch (error) {
      if (mounted) {
        final appError = AppErrorHandler.parseError(error);
        AppErrorHandler.showErrorSnackbar(context, appError,
            onRetry: _submitApplication);
      }
    } finally {
      if (mounted) {
        _applicationState.isSubmitting = false;
      }
    }
  }
}