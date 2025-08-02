import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/services/deal_suggestions_service.dart';
import 'package:deadhour/widgets/common/dead_hour_app_bar.dart';
import 'package:deadhour/screens/business/create_deal_screen/widgets/create_deal_header.dart';
import 'package:deadhour/screens/business/create_deal_screen/widgets/create_deal_suggestions_section.dart';
import 'package:deadhour/screens/business/create_deal_screen/widgets/create_deal_information_form.dart';
import 'package:deadhour/screens/business/create_deal_screen/widgets/create_deal_type_selector.dart';
import 'package:deadhour/screens/business/create_deal_screen/widgets/create_deal_schedule_section.dart';
import 'package:deadhour/screens/business/create_deal_screen/widgets/create_deal_community_form.dart';
import 'package:deadhour/screens/business/create_deal_screen/widgets/create_deal_action_buttons.dart';

class CreateDealScreen extends StatefulWidget {
  const CreateDealScreen({super.key});

  @override
  State<CreateDealScreen> createState() => _CreateDealScreenState();
}

class _CreateDealScreenState extends State<CreateDealScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController =
      TextEditingController(text: 'Afternoon Coffee Special');
  final TextEditingController _communityMessageController = TextEditingController(
      text:
          'Perfect afternoon study spot! Quiet atmosphere, great coffee, free WiFi. Beat the afternoon energy dip with our special! ☕');

  String _dealType = 'percentage';
  int _discountPercentage = 35;
  String _targetItems = 'all';
  TimeOfDay _startTime = const TimeOfDay(hour: 14, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 16, minute: 0);
  final List<String> _selectedDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  int _maxCustomersPerDay = 20;
  int _maxPerTimeSlot = 8;
  bool _notifyCommunity = true;
  bool _isHalalCertified = false;
  bool _isPrayerTimeAware = false;
  final String _businessType = 'food';
  bool _showSuggestions = true;

  @override
  void dispose() {
    _titleController.dispose();
    _communityMessageController.dispose();
    super.dispose();
  }

  List<DealSuggestion> _getSuggestions() {
    return DealSuggestionsService().generateSuggestions(
      businessType: _businessType,
      currentTime: TimeOfDay.now(),
      city: 'Casablanca',
      dayOfWeek: DateTime.now().weekday,
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: AppColors.success),
              SizedBox(width: 8),
              Text('Deal Created!'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('🔥 ${_titleController.text}'),
              const SizedBox(height: 12),
              Text('$_discountPercentage% OFF during dead hours'),
              Text(
                  '${_startTime.format(context)} - ${_endTime.format(context)}'),
              const SizedBox(height: 12),
              const Text('Your deal will be:'),
              const Text('✅ Posted to community rooms'),
              const Text('✅ Visible in discovery feed'),
              const Text('✅ Sent as push notification'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '💰 Expected revenue boost: +67% vs empty dead hours',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.moroccoGreen,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                context.pop();
              },
              child: const Text('View Dashboard'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                context.pop();
              },
              child: const Text('Create Another Deal'),
            ),
          ],
        ),
      );
    }
  }

  void _applySuggestion(DealSuggestion suggestion) {
    setState(() {
      _titleController.text = suggestion.title;
      _discountPercentage = suggestion.discountPercentage;
      _startTime = suggestion.targetTime;
      _endTime = suggestion.endTime;

      // Generate a community message suggestion
      final messageSuggestions =
          DealSuggestionsService().getCommunityMessageSuggestions(
        dealTitle: suggestion.title,
        businessType: _businessType,
        discountPercentage: suggestion.discountPercentage,
      );

      if (messageSuggestions.isNotEmpty) {
        _communityMessageController.text = messageSuggestions.first;
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
                        onToggleSuggestions: () => setState(() => _showSuggestions = !_showSuggestions),
                        suggestions: _getSuggestions(),
                        onApplySuggestion: _applySuggestion,
                      ),
                    if (_showSuggestions) const SizedBox(height: 24),

                    // Deal Information Section
                    CreateDealInformationForm(
                      titleController: _titleController,
                      isHalalCertified: _isHalalCertified,
                      isPrayerTimeAware: _isPrayerTimeAware,
                      onHalalChanged: (value) => setState(() => _isHalalCertified = value),
                      onPrayerTimeAwareChanged: (value) => setState(() => _isPrayerTimeAware = value),
                    ),
                    const SizedBox(height: 24),

                    // Deal Type Section
                    CreateDealTypeSelector(
                      dealType: _dealType,
                      discountPercentage: _discountPercentage,
                      onDealTypeChanged: (type) => setState(() => _dealType = type),
                      onDiscountPercentageChanged: (discount) => setState(() => _discountPercentage = discount),
                    ),
                    const SizedBox(height: 24),

                    // Dead Hours Schedule Section
                    CreateDealScheduleSection(
                      selectedDays: _selectedDays,
                      weekDays: const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                      startTime: _startTime,
                      endTime: _endTime,
                      targetItems: _targetItems,
                      maxCustomersPerDay: _maxCustomersPerDay,
                      maxPerTimeSlot: _maxPerTimeSlot,
                      onDaySelectionChanged: (day, isSelected) => setState(() {
                        if (isSelected && !_selectedDays.contains(day)) {
                          _selectedDays.add(day);
                        } else if (!isSelected && _selectedDays.contains(day)) {
                          _selectedDays.remove(day);
                        }
                      }),
                      onStartTimePressed: () async {
                        final time = await showTimePicker(context: context, initialTime: _startTime);
                        if (time != null) setState(() => _startTime = time);
                      },
                      onEndTimePressed: () async {
                        final time = await showTimePicker(context: context, initialTime: _endTime);
                        if (time != null) setState(() => _endTime = time);
                      },
                      onTargetItemsChanged: (items) => setState(() => _targetItems = items),
                      onMaxCustomersChanged: (value) => setState(() => _maxCustomersPerDay = value),
                      onMaxPerTimeSlotChanged: (value) => setState(() => _maxPerTimeSlot = value),
                    ),
                    const SizedBox(height: 24),

                    // Community Message Section
                    CreateDealCommunityForm(
                      communityMessageController: _communityMessageController,
                      notifyCommunity: _notifyCommunity,
                      onNotifyCommunityChanged: (value) => setState(() => _notifyCommunity = value),
                    ),
                    const SizedBox(height: 32),

                    // Action Buttons
                    CreateDealActionButtons(
                      onSaveDraftPressed: () {},
                      onPreviewPressed: _submitForm,
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
}