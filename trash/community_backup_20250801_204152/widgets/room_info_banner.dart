import 'package:flutter/material.dart';

import '../../../utils/theme.dart';

class RoomInfoBanner extends StatelessWidget {
  const RoomInfoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.info_outline,
            size: 16,
            color: AppTheme.moroccoGreen,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Share deals, form groups, and discover amazing places together!',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.moroccoGreen,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
