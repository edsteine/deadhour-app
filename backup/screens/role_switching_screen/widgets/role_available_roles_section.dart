import 'package:flutter/material.dart';
import '../../../models/user.dart';
import '../../../utils/theme.dart';
import 'role_card.dart';

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
          child: RoleCard(
            role: role,
            isActive: false,
            isPending: pendingRole == role,
            onActionPressed: () => onRoleAction(role, false),
          ),
        )),
      ],
    );
  }
}