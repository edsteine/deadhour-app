import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

class EmptyValidationsWidget extends StatelessWidget {
  const EmptyValidationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              Icons.people_outline,
              size: 48,
              color: AppTheme.secondaryText,
            ),
            SizedBox(height: 12),
            Text(
              'Be the first to validate!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Help the community by sharing your experience with this deal.',
              style: TextStyle(
                color: AppTheme.secondaryText,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}