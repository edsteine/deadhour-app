import 'package:deadhour_flutter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';
import '../../widgets/common/enhanced_app_bar.dart';

class CreateDealScreen extends StatefulWidget {
  const CreateDealScreen({super.key});

  @override
  State<CreateDealScreen> createState() => _CreateDealScreenState();
}

class _CreateDealScreenState extends State<CreateDealScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _originalPriceController = TextEditingController();
  final TextEditingController _discountPercentageController = TextEditingController();
  final TextEditingController _totalSpotsController = TextEditingController();
  final TextEditingController _validUntilController = TextEditingController();
  String? _selectedCategory;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _originalPriceController.dispose();
    _discountPercentageController.dispose();
    _totalSpotsController.dispose();
    _validUntilController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _updateValidUntilText();
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _updateValidUntilText();
      });
    }
  }

  void _updateValidUntilText() {
    if (_selectedDate != null && _selectedTime != null) {
      final DateTime combinedDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );
      _validUntilController.text = combinedDateTime.toLocal().toString().split('.')[0];
    } else if (_selectedDate != null) {
      _validUntilController.text = _selectedDate!.toLocal().toString().split(' ')[0];
    } else if (_selectedTime != null) {
      _validUntilController.text = _selectedTime!.format(context);
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process data
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Deal created successfully!'),
          backgroundColor: AppColors.success,
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EnhancedAppBar(
        title: 'Create New Deal',
        showBackButton: true,
        showGradient: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Deal Title',
                  hintText: 'e.g., Afternoon Coffee Special',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a deal title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Briefly describe your deal',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                ),
                items: const [
                  DropdownMenuItem(value: 'food', child: Text('Food & Dining')),
                  DropdownMenuItem(value: 'entertainment', child: Text('Entertainment')),
                  DropdownMenuItem(value: 'wellness', child: Text('Wellness')),
                  DropdownMenuItem(value: 'sports', child: Text('Sports')),
                  DropdownMenuItem(value: 'tourism', child: Text('Tourism')),
                  DropdownMenuItem(value: 'family', child: Text('Family')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _originalPriceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Original Price (MAD)',
                        hintText: 'e.g., 100',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter original price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Invalid number';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: TextFormField(
                      controller: _discountPercentageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Discount (%)',
                        hintText: 'e.g., 40',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter discount';
                        }
                        final discount = int.tryParse(value);
                        if (discount == null || discount < 0 || discount > 100) {
                          return 'Invalid percentage';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _totalSpotsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Total Spots Available',
                  hintText: 'e.g., 50',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter total spots';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Invalid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _validUntilController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Valid Until',
                  hintText: 'Select date and time',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.access_time),
                    onPressed: () => _selectTime(context),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select valid until date/time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.xl),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Create Deal'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



