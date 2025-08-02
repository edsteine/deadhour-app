import 'package:flutter/material.dart';
import 'package:deadhour/models/user.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/screens/role_switching_screen/models/role_data.dart';

class RolePrimarySelector extends StatelessWidget {
  final Set<UserRole> activeRoles;
  final UserRole primaryRole;
  final ValueChanged<UserRole> onPrimaryRoleChanged;

  const RolePrimarySelector({
    super.key,
    required this.activeRoles,
    required this.primaryRole,
    required this.onPrimaryRoleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.star_border,
                  color: AppTheme.moroccoGreen,
                  size: 24,
                ),
                SizedBox(width: AppTheme.spacing12),
                Text(
                  'Primary Role',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              'Your primary role determines your default app experience',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            // Primary role selector
            ...UserRole.values.where((role) => activeRoles.contains(role)).map((role) {
              final roleInfo = RoleData.getRoleInfo(role);
              final isSelected = role == primaryRole;
              
              return Padding(
                padding: const EdgeInsets.only(bottom: AppTheme.spacing8),
                child: RadioListTile<UserRole>(
                  value: role,
                  groupValue: primaryRole,
                  onChanged: (value) {
                    if (value != null) {
                      onPrimaryRoleChanged(value);
                    }
                  },
                  title: Row(
                    children: [
                      Icon(
                        roleInfo['icon'] as IconData,
                        color: roleInfo['color'] as Color,
                        size: 20,
                      ),
                      const SizedBox(width: AppTheme.spacing8),
                      Text(
                        roleInfo['title'] as String,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? AppTheme.moroccoGreen : null,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(roleInfo['subtitle'] as String),
                  activeColor: AppTheme.moroccoGreen,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}