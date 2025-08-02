import 'package:deadhour/widgets/common/dead_hour_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/services/deal_suggestions_service.dart';
import 'package:deadhour/screens/business/create_deal_screen/widgets/create_deal_header.dart';
import 'package:deadhour/screens/business/create_deal_screen/widgets/create_deal_suggestions_section.dart';
import 'package:deadhour/screens/business/create_deal_screen/widgets/create_deal_information_form.dart';
import 'package:deadhour/screens/business/create_deal_screen/widgets/create_deal_type_selector.dart';
import 'package:deadhour/screens/business/create_deal_screen/widgets/create_deal_schedule_section.dart';
import 'package:deadhour/screens/business/create_deal_screen/widgets/create_deal_community_form.dart';
import 'package:deadhour/screens/business/create_deal_screen/widgets/create_deal_action_buttons.dart';
import 'package:deadhour/screens/business/create_deal_screen/widgets/create_deal_success_dialog.dart';

class CreateDealScreen extends StatefulWidget {
  const CreateDealScreen({super.key});

  @override
  State<CreateDealScreen> createState() => _CreateDealScreenState();
}

class _CreateDealScreenState extends State<CreateDealScreen> {
  final _formKey = GlobalKey<FormState>();
  String _businessType = 'restaurant';
  String _dealTitle = '';
  String _dealDescription = '';
  double _discountPercentage = 20.0;
  String _dealType = 'percentage';
  bool _showSuggestions = true;
  TimeOfDay _startTime = const TimeOfDay(hour: 14, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 18, minute: 0);
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  List<DealSuggestion> get _suggestions {
    return DealSuggestionsService().generateSuggestions(
      businessType: _businessType,
      currentTime: TimeOfDay.now(),
      city: 'Casablanca',
      dayOfWeek: DateTime.now().weekday,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _titleController.text.isNotEmpty) {
      CreateDealSuccessDialog.show(
        context,
        dealTitle: _titleController.text,
        discountPercentage: _discountPercentage,
        startTime: _startTime,
        endTime: _endTime,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DeadHourAppBar(
        title: 'Create Dead Hour Deal',
        showBackButton: true,
        backgroundColor: AppTheme.moroccoGreen,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with dead hours optimization tip
            const CreateDealHeader(),
            
            // Form content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Smart Suggestions Section
                    if (_showSuggestions) 
                      CreateDealSuggestionsSection(
                        showSuggestions: _showSuggestions,
                        onToggleSuggestions: () => setState(() => 
                          _showSuggestions = !_showSuggestions
                        ),
                        suggestions: _suggestions,
                        onApplySuggestion: _applySuggestion,
                      ),
                    if (_showSuggestions) const SizedBox(height: 24),

                    // Deal Information Section
                    CreateDealInformationForm(
                      titleController: _dealState.titleController,
                      isHalalCertified: _dealState.isHalalCertified,
                      isPrayerTimeAware: _dealState.isPrayerTimeAware,
                      onHalalChanged: (value) => setState(() => 
                        _dealState.updateFeatures(newIsHalalCertified: value)
                      ),
                      onPrayerTimeAwareChanged: (value) => setState(() => 
                        _dealState.updateFeatures(newIsPrayerTimeAware: value)
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Deal Type Section
                    CreateDealTypeSelector(
                      dealType: _dealState.dealType,
                      discountPercentage: _dealState.discountPercentage,
                      onDealTypeChanged: (value) => setState(() => 
                        _dealState.updateDealType(newDealType: value)
                      ),
                      onDiscountPercentageChanged: (value) => setState(() => 
                        _dealState.updateDealType(newDiscountPercentage: value)
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Schedule and Capacity Section
                    CreateDealScheduleSection(
                      selectedDays: _dealState.selectedDays,
                      weekDays: _dealState.weekDays,
                      startTime: _dealState.startTime,
                      endTime: _dealState.endTime,
                      targetItems: _dealState.targetItems,
                      maxCustomersPerDay: _dealState.maxCustomersPerDay,
                      maxPerTimeSlot: _dealState.maxPerTimeSlot,
                      onDaySelectionChanged: _handleDaySelection,
                      onStartTimePressed: _selectStartTime,
                      onEndTimePressed: _selectEndTime,
                      onTargetItemsChanged: (value) => setState(() => 
                        _dealState.updateDealType(newTargetItems: value)
                      ),
                      onMaxCustomersChanged: (value) => setState(() => 
                        _dealState.updateCapacity(newMaxCustomersPerDay: value)
                      ),
                      onMaxPerTimeSlotChanged: (value) => setState(() => 
                        _dealState.updateCapacity(newMaxPerTimeSlot: value)
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Community Message Section
                    CreateDealCommunityForm(
                      communityMessageController: _dealState.communityMessageController,
                      notifyCommunity: _dealState.notifyCommunity,
                      onNotifyCommunityChanged: (value) => setState(() => 
                        _dealState.updateFeatures(newNotifyCommunity: value)
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Action Buttons
                    CreateDealActionButtons(
                      onPreviewPressed: () {}, // TODO: Implement preview
                      onSaveDraftPressed: () {}, // TODO: Implement save draft
                      onPublishPressed: _submitForm,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleDaySelection(String day, bool selected) {
    setState(() {
      final newDays = List<String>.from(_dealState.selectedDays);
      if (selected) {
        newDays.add(day);
      } else {
        newDays.remove(day);
      }
      _dealState.updateSchedule(newSelectedDays: newDays);
    });
  }

  Future<void> _selectStartTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _dealState.startTime,
    );
    if (time != null) {
      setState(() => _dealState.updateSchedule(newStartTime: time));
    }
  }

  Future<void> _selectEndTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _dealState.endTime,
    );
    if (time != null) {
      setState(() => _dealState.updateSchedule(newEndTime: time));
    }
  }

  void _applySuggestion(DealSuggestion suggestion) {
    setState(() {
      // Use the connected state update method
      _dealState.updateFromSuggestion(suggestion, _dealState.businessType);

      // Generate a community message suggestion
      final messageSuggestions =
          DealSuggestionsService().getCommunityMessageSuggestions(
        dealTitle: suggestion.title,
        businessType: _dealState.businessType,
        discountPercentage: suggestion.discountPercentage,
      );

      if (messageSuggestions.isNotEmpty) {
        _dealState.communityMessageController.text = messageSuggestions.first;
      }
    });

    // Show applied confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Applied suggestion: ${suggestion.title}'),
        backgroundColor: AppTheme.moroccoGreen,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}