import '../../utils/performance_utils.dart';
import 'package:flutter/material.dart';
import 'notification_badge_widget.dart';
import 'search_bottom_sheet_widget.dart';

/// App bar actions widget containing all action buttons
class AppBarActionsWidget extends StatelessWidget {
  final List<Widget>? customActions;
  final bool showBusinessActions;
  final bool showTourismActions;
  final bool showSearch;
  final bool showNotifications;
  final VoidCallback? onCreateDealPressed;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onNotificationsPressed;
  final VoidCallback? onMenuPressed;
  final Color? iconColor;

  const AppBarActionsWidget({
    super.key,
    this.customActions,
    this.showBusinessActions = false,
    this.showTourismActions = false,
    this.showSearch = false,
    this.showNotifications = false,
    this.onCreateDealPressed,
    this.onSearchPressed,
    this.onNotificationsPressed,
    this.onMenuPressed,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];

    // Custom actions first
    if (customActions != null) {
      actions.addAll(customActions!);
    }

    // Business actions
    if (showBusinessActions) {
      actions.add(_buildBusinessAction(context));
    }

    // Tourism actions
    if (showTourismActions) {
      actions.add(_buildTourismAction(context));
    }

    // Search action
    if (showSearch) {
      actions.add(_buildSearchAction(context));
    }

    // Notifications action
    if (showNotifications) {
      actions.add(_buildNotificationAction(context));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: actions,
    );
  }

  Widget _buildBusinessAction(BuildContext context) {
    return IconButton(
      onPressed: () {
        PerformanceUtils.hapticFeedback(HapticFeedbackType.medium);
        if (onCreateDealPressed != null) {
          onCreateDealPressed!();
        } else {
          _showCreateDealAlert(context);
        }
      },
      icon: Icon(Icons.add_business, color: iconColor),
      tooltip: 'Create Deal',
    );
  }

  Widget _buildTourismAction(BuildContext context) {
    return IconButton(
      onPressed: () {
        PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
        if (onMenuPressed != null) {
          onMenuPressed!();
        } else {
          _showTourismMenu(context);
        }
      },
      icon: Icon(Icons.more_vert, color: iconColor),
      tooltip: 'Tourism Menu',
    );
  }

  Widget _buildSearchAction(BuildContext context) {
    return IconButton(
      onPressed: () {
        PerformanceUtils.hapticFeedback(HapticFeedbackType.medium);
        if (onSearchPressed != null) {
          onSearchPressed!();
        } else {
          _showSearchDialog(context);
        }
      },
      icon: Icon(Icons.search, color: iconColor),
      tooltip: 'Search',
    );
  }

  Widget _buildNotificationAction(BuildContext context) {
    return NotificationBadgeWidget(
      onPressed: onNotificationsPressed,
      iconColor: iconColor,
      showBadge: true,
      badgeCount: 3,
    );
  }

  void _showSearchDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SearchBottomSheetWidget(),
    );
  }

  void _showCreateDealAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Deal'),
        content: const Text(
          'Are you a business owner? Switch to business mode to create deals for your venue.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to business role or profile
            },
            child: const Text('Go to Business'),
          ),
        ],
      ),
    );
  }

  void _showTourismMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Tourism Options',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              subtitle: const Text('العربية • Français • English'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Premium Features'),
              subtitle: const Text('Unlock expert connections'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Tourist Guide'),
              subtitle: const Text('How to use DeadHour in Morocco'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}