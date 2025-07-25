import 'package:deadhour/widgets/common/dead_hour_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';

class CreateDealScreen extends StatefulWidget {
  const CreateDealScreen({super.key});

  @override
  State<CreateDealScreen> createState() => _CreateDealScreenState();
}

class _CreateDealScreenState extends State<CreateDealScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController(text: 'Afternoon Coffee Special');
  final TextEditingController _communityMessageController = TextEditingController(
    text: 'Perfect afternoon study spot! Quiet atmosphere, great coffee, free WiFi. Beat the afternoon energy dip with our special! ☕'
  );
  
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

  final List<String> _weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

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
              Text('${_startTime.format(context)} - ${_endTime.format(context)}'),
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.moroccoGreen, AppTheme.darkGreen],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text('💡', style: TextStyle(fontSize: 24)),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Boost Revenue During Slow Times',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Turn empty tables into profit with community-driven deals',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Text('🎯', style: TextStyle(fontSize: 16)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Recommended: 30-40% discount for 14:00-16:00 dead hours',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Form content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Deal Information Section
                    _buildSectionHeader('🎯 Deal Information'),
                    const SizedBox(height: 16),
                    
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Deal Name',
                        hintText: 'e.g., Afternoon Coffee Special',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a deal name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('Halal Certified'),
                      subtitle: const Text('Indicate if this deal is for halal-certified venues/products'),
                      value: _isHalalCertified,
                      onChanged: (value) {
                        setState(() {
                          _isHalalCertified = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      title: const Text('Prayer Time Aware'),
                      subtitle: const Text('Consider prayer times when promoting this deal'),
                      value: _isPrayerTimeAware,
                      onChanged: (value) {
                        setState(() {
                          _isPrayerTimeAware = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // Deal Type Section
                    _buildSectionHeader('💰 Deal Type'),
                    const SizedBox(height: 12),
                    
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          RadioListTile<String>(
                            title: Text('📉 Percentage Discount ($_discountPercentage% OFF)'),
                            subtitle: Text('Preview: 45 MAD → ${(45 * (100 - _discountPercentage) / 100).round()} MAD'),
                            value: 'percentage',
                            groupValue: _dealType,
                            onChanged: (value) => setState(() => _dealType = value!),
                            activeColor: AppTheme.moroccoGreen,
                          ),
                          RadioListTile<String>(
                            title: const Text('💰 Fixed Price (Coffee + Pastry = 25 MAD)'),
                            value: 'fixed',
                            groupValue: _dealType,
                            onChanged: (value) => setState(() => _dealType = value!),
                            activeColor: AppTheme.moroccoGreen,
                          ),
                          RadioListTile<String>(
                            title: const Text('🎁 Buy One Get One'),
                            value: 'bogo',
                            groupValue: _dealType,
                            onChanged: (value) => setState(() => _dealType = value!),
                            activeColor: AppTheme.moroccoGreen,
                          ),
                        ],
                      ),
                    ),
                    
                    if (_dealType == 'percentage') ...[
                      const SizedBox(height: 16),
                      Text('Discount Amount: $_discountPercentage%'),
                      Slider(
                        value: _discountPercentage.toDouble(),
                        min: 10,
                        max: 70,
                        divisions: 12,
                        label: '$_discountPercentage%',
                        onChanged: (value) => setState(() => _discountPercentage = value.round()),
                        activeColor: AppTheme.moroccoGreen,
                      ),
                    ],

                    const SizedBox(height: 24),

                    // Dead Hours Schedule Section
                    _buildSectionHeader('⏰ Dead Hours Schedule'),
                    const SizedBox(height: 12),
                    
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.05),
                        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Days:', style: TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: _weekDays.map((day) {
                              final isSelected = _selectedDays.contains(day);
                              return FilterChip(
                                label: Text(day),
                                selected: isSelected,
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected) {
                                      _selectedDays.add(day);
                                    } else {
                                      _selectedDays.remove(day);
                                    }
                                  });
                                },
                                selectedColor: AppTheme.moroccoGreen.withValues(alpha: 0.2),
                                checkmarkColor: AppTheme.moroccoGreen,
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Start Time:', style: TextStyle(fontWeight: FontWeight.w600)),
                                    InkWell(
                                      onTap: () async {
                                        final time = await showTimePicker(
                                          context: context,
                                          initialTime: _startTime,
                                        );
                                        if (time != null) setState(() => _startTime = time);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey.shade300),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(_startTime.format(context)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('End Time:', style: TextStyle(fontWeight: FontWeight.w600)),
                                    InkWell(
                                      onTap: () async {
                                        final time = await showTimePicker(
                                          context: context,
                                          initialTime: _endTime,
                                        );
                                        if (time != null) setState(() => _endTime = time);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey.shade300),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(_endTime.format(context)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Duration: ${_endTime.hour - _startTime.hour} hours daily',
                            style: const TextStyle(fontSize: 12, color: AppTheme.secondaryText),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Target Items Section
                    _buildSectionHeader('🎯 Target Items'),
                    const SizedBox(height: 12),
                    
                    RadioListTile<String>(
                      title: const Text('All menu items'),
                      value: 'all',
                      groupValue: _targetItems,
                      onChanged: (value) => setState(() => _targetItems = value!),
                      activeColor: AppTheme.moroccoGreen,
                    ),
                    RadioListTile<String>(
                      title: const Text('Coffee & beverages only'),
                      value: 'beverages',
                      groupValue: _targetItems,
                      onChanged: (value) => setState(() => _targetItems = value!),
                      activeColor: AppTheme.moroccoGreen,
                    ),

                    const SizedBox(height: 24),

                    // Deal Capacity Section
                    _buildSectionHeader('👥 Deal Capacity'),
                    const SizedBox(height: 12),
                    
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Max customers per day:'),
                              Slider(
                                value: _maxCustomersPerDay.toDouble(),
                                min: 5,
                                max: 50,
                                divisions: 9,
                                label: '$_maxCustomersPerDay',
                                onChanged: (value) => setState(() => _maxCustomersPerDay = value.round()),
                                activeColor: AppTheme.moroccoGreen,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Max per time slot:'),
                              Slider(
                                value: _maxPerTimeSlot.toDouble(),
                                min: 2,
                                max: 20,
                                divisions: 9,
                                label: '$_maxPerTimeSlot',
                                onChanged: (value) => setState(() => _maxPerTimeSlot = value.round()),
                                activeColor: AppTheme.moroccoGreen,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Community Message Section
                    _buildSectionHeader('💬 Community Message'),
                    const SizedBox(height: 12),
                    
                    TextFormField(
                      controller: _communityMessageController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: 'Tell the community why this deal is special...',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 16),
                    
                    SwitchListTile(
                      title: const Text('📱 Notify Community'),
                      subtitle: const Text('Send push notification to relevant rooms'),
                      value: _notifyCommunity,
                      onChanged: (value) => setState(() => _notifyCommunity = value),
                      activeColor: AppTheme.moroccoGreen,
                    ),

                    const SizedBox(height: 32),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.preview),
                            label: const Text('Preview Deal'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.save),
                            label: const Text('Save Draft'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _submitForm,
                        icon: const Icon(Icons.rocket_launch),
                        label: const Text('Publish Deal'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.moroccoGreen,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
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

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppTheme.moroccoGreen,
      ),
    );
  }
}