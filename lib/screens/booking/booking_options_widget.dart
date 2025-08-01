import '../../utils/app_theme.dart';
import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

class BookingOptionsWidget extends StatelessWidget {
  final String selectedBookingType;
  final ValueChanged<String> onBookingTypeChanged;

  const BookingOptionsWidget({
    super.key,
    required this.selectedBookingType,
    required this.onBookingTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '👥 Booking Options:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildRadioOption('solo', 'Solo booking (just you)'),
        _buildRadioOption('join_group', 'Join community group (3 people)'),
        _buildRadioOption('create_group', 'Create new group (invite friends)'),
      ],
    );
  }

  Widget _buildRadioOption(String value, String label) {
    return RadioListTile<String>(
      value: value,
      groupValue: selectedBookingType,
      onChanged: (String? newValue) {
        if (newValue != null) {
          onBookingTypeChanged(newValue);
        }
      },
      title: Text(label),
      contentPadding: EdgeInsets.zero,
      activeColor: AppTheme.moroccoGreen,
    );
  }
}