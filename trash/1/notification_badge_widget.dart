import '../../utils/performance_utils.dart';
import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import 'notifications_bottom_sheet.dart';


/// Notification badge widget with badge indicator
class NotificationBadgeWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool showBadge;
  final int badgeCount;
  final Color? iconColor;

  const NotificationBadgeWidget({
    super.key,
    this.onPressed,
    this.showBadge = true,
    this.badgeCount = 0,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
        if (onPressed != null) {
          onPressed!();
        } else {
          _showNotifications(context);
        }
      },
      icon: Stack(
        children: [
          Icon(
            Icons.notifications_outlined,
            color: iconColor ?? Colors.white,
          ),
          if (showBadge && badgeCount > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: badgeCount > 9 ? 16 : 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                ),
                child: badgeCount > 9
                    ? const Center(
                        child: Text(
                          '9+',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : null,
              ),
            ),
        ],
      ),
      tooltip: 'Notifications',
    );
  }

  void _showNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const NotificationsBottomSheet(),
    );
  }
}


