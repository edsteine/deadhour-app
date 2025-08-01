


import 'package:deadhour/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class RoleToggleWidget extends ConsumerWidget {
  const RoleToggleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roleNotifier = ref.watch(roleToggleProvider.notifier);
    final currentRole = ref.watch(roleToggleProvider);
    final isLoggedIn = roleNotifier.isLoggedIn;

    if (!isLoggedIn) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: Border.all(color: AppTheme.hintText.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: UserRole.values
            .where((role) =>
                role != UserRole.driver &&
                role != UserRole.host &&
                role != UserRole.chef &&
                role != UserRole.photographer)
            .map((role) {
          final isSelected = currentRole == role;

          return Expanded(
            child: GestureDetector(
              onTap: () => roleNotifier.setRole(role),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  vertical: AppTheme.spacing12,
                  horizontal: AppTheme.spacing8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? role.color : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppTheme.radiusLarge - 2),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      role.icon,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: AppTheme.spacing4),
                    Text(
                      role.label,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color:
                            isSelected ? Colors.white : AppTheme.secondaryText,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

