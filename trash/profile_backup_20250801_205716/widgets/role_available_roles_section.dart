import '../models/user.dart';
import '../services/role_data.dart';
import 'package:flutter/material.dart';
import '../../../utils/theme.dart';

/// Available roles section showing inactive roles that can be added
class RoleAvailableRolesSection extends StatelessWidget {
  final Set<UserRole> activeRoles;
  final UserRole? pendingRole;
  final Function(UserRole, bool) onRoleAction;

  const RoleAvailableRolesSection({
    super.key,
    required this.activeRoles,
    required this.pendingRole,
    required this.onRoleAction,
  });

  @override
  Widget build(BuildContext context) {
    final inactiveRoles = UserRole.values
        .where((role) => !activeRoles.contains(role))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add More Roles',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppTheme.spacing12),
        ...inactiveRoles.map((role) => Padding(
          padding: const EdgeInsets.only(bottom: AppTheme.spacing12),
          child: _buildRoleCard(role, isActive: false),
        )),
      ],
    );
  }

  Widget _buildRoleCard(UserRole role, {required bool isActive}) {
    final roleInfo = RoleData.roleData[role]!;
    final isPending = pendingRole == role;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacing8),
                  decoration: BoxDecoration(
                    color: (roleInfo['color'] as Color).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                  ),
                  child: Icon(
                    roleInfo['icon'] as IconData,
                    color: roleInfo['color'] as Color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppTheme.spacing12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            roleInfo['title'] as String,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.spacing8,
                              vertical: AppTheme.spacing4,
                            ),
                            decoration: BoxDecoration(
                              color: (roleInfo['color'] as Color).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              roleInfo['price'] as String,
                              style: TextStyle(
                                color: roleInfo['color'] as Color,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        roleInfo['subtitle'] as String,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing12),
            Text(
              roleInfo['description'] as String,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: AppTheme.spacing12),
            
            // Features list
            ...((roleInfo['features'] as List<String>).take(3).map((feature) =>
              Padding(
                padding: const EdgeInsets.only(bottom: AppTheme.spacing4),
                child: Row(
                  children: [
                    Icon(
                      Icons.check,
                      color: roleInfo['color'] as Color,
                      size: 16,
                    ),
                    const SizedBox(width: AppTheme.spacing8),
                    Expanded(
                      child: Text(
                        feature,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            )),
            
            if ((roleInfo['features'] as List<String>).length > 3) ...[
              const SizedBox(height: AppTheme.spacing4),
              Text(
                '+${(roleInfo['features'] as List<String>).length - 3} more features',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
            
            const SizedBox(height: AppTheme.spacing16),
            
            // Action button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isPending ? null : () => onRoleAction(role, isActive),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isActive ? Colors.red : (roleInfo['color'] as Color),
                  foregroundColor: Colors.white,
                ),
                child: isPending
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(isActive ? 'Remove Role' : 'Add Role'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}