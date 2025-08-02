import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/utils/performance_utils.dart';
import 'package:deadhour/utils/error_utils.dart';
import 'package:deadhour/screens/cultural/state/application_state.dart';
import 'package:deadhour/screens/cultural/widgets/progress_indicator_widget.dart';
import 'package:deadhour/screens/cultural/widgets/personal_info_step.dart';
import 'package:deadhour/screens/cultural/widgets/expertise_step.dart';
import 'package:deadhour/screens/cultural/widgets/experience_step.dart';
import 'package:deadhour/screens/cultural/widgets/review_step.dart';
import 'package:deadhour/screens/cultural/widgets/application_action_buttons.dart';
import 'package:deadhour/screens/cultural/widgets/submission_success_dialog.dart';

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