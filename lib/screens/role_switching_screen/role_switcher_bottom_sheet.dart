import 'package:deadhour/utils/haptic_feedback_type.dart';

import 'package:deadhour/utils/performance_utils.dart';
import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';

/// Role switcher bottom sheet with intuitive design
class RoleSwitcherBottomSheet extends StatelessWidget {
  final String currentRole;
  final List<String> availableRoles;
  final Function(String) onRoleChanged;

  const RoleSwitcherBottomSheet({
    super.key,
    required this.currentRole,
    required this.availableRoles,
    required this.onRoleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                const Text(
                  'Switch Role',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),

          // Role options
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: availableRoles.length,
            itemBuilder: (context, index) {
              final role = availableRoles[index];
              final isActive = role.toLowerCase() == currentRole.toLowerCase();
              final roleInfo = _getRoleInfo(role);

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: roleInfo['color'].withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(24),
                      border: isActive
                          ? Border.all(
                              color: roleInfo['color'],
                              width: 2,
                            )
                          : null,
                    ),
                    child: Icon(
                      roleInfo['icon'],
                      color: roleInfo['color'],
                      size: 24,
                    ),
                  ),
                  title: Text(
                    roleInfo['title'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                      color: isActive ? roleInfo['color'] : Colors.black87,
                    ),
                  ),
                  subtitle: Text(
                    roleInfo['subtitle'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  trailing: isActive
                      ? Icon(
                          Icons.check_circle,
                          color: roleInfo['color'],
                        )
                      : const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey,
                        ),
                  onTap: () {
                    if (!isActive) {
                      PerformanceUtils.hapticFeedback(HapticFeedbackType.medium);
                      Navigator.pop(context);
                      onRoleChanged(role);
                    }
                  },
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // Add new role option
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.grey,
                  size: 24,
                ),
              ),
              title: const Text(
                'Add New Role',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              subtitle: Text(
                'Unlock more features',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _showAddRoleDialog(context);
              },
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Map<String, dynamic> _getRoleInfo(String role) {
    switch (role.toLowerCase()) {
      case 'consumer':
        return {
          'title': 'Explorer',
          'subtitle': 'Discover deals and experiences',
          'icon': Icons.explore,
          'color': AppTheme.moroccoGreen,
        };
      case 'business':
        return {
          'title': 'Business Owner',
          'subtitle': 'Manage venues and create deals',
          'icon': Icons.business,
          'color': Colors.blue,
        };
      case 'guide':
        return {
          'title': 'Local Guide',
          'subtitle': 'Share cultural expertise',
          'icon': Icons.person_pin,
          'color': Colors.purple,
        };
      case 'tourism':
      case 'tourist':
        return {
          'title': 'Tourism Expert',
          'subtitle': 'Curate travel experiences',
          'icon': Icons.flight_takeoff,
          'color': Colors.orange,
        };
      case 'premium':
        return {
          'title': 'Premium Member',
          'subtitle': 'Enhanced features across all roles',
          'icon': Icons.star,
          'color': AppTheme.moroccoGold,
        };
      default:
        return {
          'title': role,
          'subtitle': 'Custom role',
          'icon': Icons.person,
          'color': Colors.grey,
        };
    }
  }

  void _showAddRoleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Role'),
        content: const Text(
          'Choose which role you\'d like to activate:\n\n'
          '• Business Owner (€30/month)\n'
          '• Local Guide (€20/month)\n'
          '• Premium Features (€15/month)\n\n'
          'Stack multiple roles for maximum earning potential!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to role selection screen
            },
            child: const Text('Explore Roles'),
          ),
        ],
      ),
    );
  }
}