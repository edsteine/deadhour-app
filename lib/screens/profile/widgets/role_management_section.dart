import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:deadhour/models/user.dart';
import 'package:deadhour/providers/role_toggle_provider.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/screens/profile/profile_screen_helpers.dart';

class RoleManagementSection extends ConsumerStatefulWidget {
  final DeadHourUser? currentUser;

  const RoleManagementSection({
    super.key,
    required this.currentUser,
  });

  @override
  ConsumerState<RoleManagementSection> createState() => _RoleManagementSectionState();
}

class _RoleManagementSectionState extends ConsumerState<RoleManagementSection> {
  @override
  Widget build(BuildContext context) {
    if (widget.currentUser == null) return const SizedBox.shrink();

    final roleNotifier = ref.watch(roleToggleProvider.notifier);
    final currentRole = ref.watch(roleToggleProvider);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.swap_horizontal_circle,
                color: AppTheme.moroccoGreen,
                size: 28,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Role Management',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryText,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => context.go('/user-type'),
                child: const Text('Add Role'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Switch between your active roles to access different features',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.secondaryText,
            ),
          ),
          const SizedBox(height: 20),
          ...(widget.currentUser!.activeRoles.map((role) {
            final isActive = role == currentRole;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: isActive
                    ? AppTheme.moroccoGreen.withValues(alpha: 0.1)
                    : AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(12),
                border: isActive
                    ? Border.all(color: AppTheme.moroccoGreen, width: 2)
                    : null,
              ),
              child: ListTile(
                leading: Icon(
                  ProfileScreenHelpers.getRoleIcon(role),
                  color:
                      isActive ? AppTheme.moroccoGreen : AppTheme.secondaryText,
                ),
                title: Text(
                  ProfileScreenHelpers.getRoleName(role),
                  style: TextStyle(
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    color:
                        isActive ? AppTheme.moroccoGreen : AppTheme.primaryText,
                  ),
                ),
                subtitle: Text(ProfileScreenHelpers.getRoleDescription(role)),
                trailing: isActive
                    ? const Icon(Icons.check_circle,
                        color: AppTheme.moroccoGreen)
                    : const Icon(Icons.radio_button_unchecked,
                        color: AppTheme.secondaryText),
                onTap: () {
                  if (!isActive) {
                    roleNotifier.setRole(role);
                    setState(() {
                      // Role switching handled by role provider
                      // In real app this would sync with backend
                    });
                  }
                },
              ),
            );
          })),
          const SizedBox(height: 16),
          Column(
            children:
                ProfileScreenHelpers.buildRoleFeatures(context, currentRole),
          ),
        ],
      ),
    );
  }
}