import 'package:flutter/material.dart';

import '../../../utils/theme.dart';
import '../models/user.dart';
import '../services/role_data.dart';

/// Quick switch widget for changing primary role
class RoleQuickSwitch extends StatelessWidget {
  final Set<UserRole> activeRoles;
  final UserRole primaryRole;
  final Function(UserRole) onQuickSwitch;

  const RoleQuickSwitch({
    super.key,
    required this.activeRoles,
    required this.primaryRole,
    required this.onQuickSwitch,
  });

  @override
  Widget build(BuildContext context) {
    if (activeRoles.length <= 1) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.swap_horiz,
                  color: AppTheme.moroccoGreen,
                  size: 24,
                ),
                SizedBox(width: AppTheme.spacing12),
                Text(
                  'Quick Switch',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              'Quickly switch your primary role experience',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            Row(
              children: activeRoles.map((role) {
                final roleInfo = RoleData.roleData[role]!;
                final isPrimary = role == primaryRole;
                
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: AppTheme.spacing8),
                    child: GestureDetector(
                      onTap: () => onQuickSwitch(role),
                      child: Container(
                        padding: const EdgeInsets.all(AppTheme.spacing12),
                        decoration: BoxDecoration(
                          color: isPrimary
                              ? (roleInfo['color'] as Color).withValues(alpha: 0.2)
                              : Colors.grey.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                          border: Border.all(
                            color: isPrimary
                                ? (roleInfo['color'] as Color)
                                : Colors.grey.withValues(alpha: 0.3),
                            width: isPrimary ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              roleInfo['icon'] as IconData,
                              color: roleInfo['color'] as Color,
                              size: 24,
                            ),
                            const SizedBox(height: AppTheme.spacing4),
                            Text(
                              roleInfo['title'] as String,
                              style: TextStyle(
                                fontWeight: isPrimary ? FontWeight.bold : FontWeight.w500,
                                fontSize: 12,
                                color: isPrimary
                                    ? (roleInfo['color'] as Color)
                                    : Colors.grey[700],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}