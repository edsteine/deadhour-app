import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';
import '../../../widgets/common/engaging_empty_state.dart';

class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? actionText;
  final VoidCallback? onAction;
  final EmptyStateType? type;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.actionText,
    this.onAction,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    // If we have a specific type, use the engaging empty state
    if (type != null) {
      return EngagingEmptyState(
        type: type!,
        customTitle: title,
        customDescription: subtitle,
        primaryAction: onAction,
        primaryActionText: actionText,
      );
    }

    // Fallback to the original simple design
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: AppTheme.lightText,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.secondaryText,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.lightText,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionText != null && onAction != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onAction!,
                child: Text(actionText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
