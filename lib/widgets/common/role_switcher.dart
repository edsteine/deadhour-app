import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user.dart';
import '../../providers/role_toggle_provider.dart';

class RoleSwitcher extends ConsumerWidget {
  const RoleSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeRoles = ref.watch(roleToggleProvider.notifier).activeRoles;
    final currentRole = ref.watch(roleToggleProvider);

    if (activeRoles.length <= 1) {
      return const SizedBox.shrink();
    }

    return PopupMenuButton<UserRole>(
      onSelected: (UserRole role) {
        ref.read(roleToggleProvider.notifier).setRole(role);
      },
      itemBuilder: (BuildContext context) {
        return activeRoles.map((UserRole role) {
          return PopupMenuItem<UserRole>(
            value: role,
            child: Text(role.toString().split('.').last),
          );
        }).toList();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              currentRole.toString().split('.').last,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}