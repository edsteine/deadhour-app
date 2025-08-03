import 'package:flutter/material.dart';
import '../../../../utils/theme.dart';

class GroupBookingCreateTab extends StatelessWidget {
  const GroupBookingCreateTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.group_add, size: 64, color: AppTheme.moroccoGreen),
          SizedBox(height: 16),
          Text(
            'Create Group Booking',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Use the + button to create a new group booking',
            style: TextStyle(color: AppTheme.secondaryText),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}