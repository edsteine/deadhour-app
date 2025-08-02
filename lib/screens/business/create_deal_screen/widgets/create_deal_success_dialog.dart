import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:deadhour/utils/theme.dart';

class CreateDealSuccessDialog extends StatelessWidget {
  final String dealTitle;
  final int discountPercentage;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  const CreateDealSuccessDialog({
    super.key,
    required this.dealTitle,
    required this.discountPercentage,
    required this.startTime,
    required this.endTime,
  });

  static void show(
    BuildContext context, {
    required String dealTitle,
    required int discountPercentage,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
  }) {
    showDialog(
      context: context,
      builder: (context) => CreateDealSuccessDialog(
        dealTitle: dealTitle,
        discountPercentage: discountPercentage,
        startTime: startTime,
        endTime: endTime,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
          Text('🔥 $dealTitle'),
          const SizedBox(height: 12),
          Text('$discountPercentage% OFF during dead hours'),
          Text('${startTime.format(context)} - ${endTime.format(context)}'),
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
    );
  }
}