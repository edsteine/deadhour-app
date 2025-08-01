



import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:deadhour/utils/app_theme.dart';








import 'package:deadhour/utils/app_colors.dart';

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
            const DealHeader(),

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
                      DealSuggestionsWidget(
                        businessType: _businessType,
                        showSuggestions: _showSuggestions,
                        onToggleSuggestions: (show) => setState(() => _showSuggestions = show),
                        onApplySuggestion: _applySuggestion,
                      ),
                    if (_showSuggestions) const SizedBox(height: 24),

                    // Deal Information Section
                    DealInformationForm(
                      titleController: _titleController,
                      isHalalCertified: _isHalalCertified,
                      isPrayerTimeAware: _isPrayerTimeAware,
                      onHalalChanged: (value) => setState(() => _isHalalCertified = value),
                      onPrayerTimeChanged: (value) => setState(() => _isPrayerTimeAware = value),
                    ),
                    const SizedBox(height: 24),

                    // Deal Type Section
                    DealTypeSelection(
                      dealType: _dealType,
                      discountPercentage: _discountPercentage,
                      onDealTypeChanged: (type) => setState(() => _dealType = type),
                      onDiscountChanged: (discount) => setState(() => _discountPercentage = discount),
                    ),
                    const SizedBox(height: 24),

                    // Dead Hours Schedule Section
                    DealScheduleForm(
                      selectedDays: _selectedDays,
                      startTime: _startTime,
                      endTime: _endTime,
                      targetItems: _targetItems,
                      onDaysChanged: (days) => setState(() {
                        _selectedDays.clear();
                        _selectedDays.addAll(days);
                      }),
                      onStartTimeChanged: (time) => setState(() => _startTime = time),
                      onEndTimeChanged: (time) => setState(() => _endTime = time),
                      onTargetItemsChanged: (items) => setState(() => _targetItems = items),
                    ),
                    const SizedBox(height: 24),

                    // Deal Capacity Section
                    DealCapacityForm(
                      maxCustomersPerDay: _maxCustomersPerDay,
                      maxPerTimeSlot: _maxPerTimeSlot,
                      onMaxCustomersChanged: (value) => setState(() => _maxCustomersPerDay = value),
                      onMaxPerSlotChanged: (value) => setState(() => _maxPerTimeSlot = value),
                    ),
                    const SizedBox(height: 24),

                    // Community Message Section
                    DealCommunityForm(
                      communityMessageController: _communityMessageController,
                      notifyCommunity: _notifyCommunity,
                      onNotifyChanged: (value) => setState(() => _notifyCommunity = value),
                    ),
                    const SizedBox(height: 32),

                    // Action Buttons
                    DealActionButtons(
                      onSubmit: _submitForm,
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