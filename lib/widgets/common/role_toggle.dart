import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/role_toggle_provider.dart';

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
        children: UserRole.values.where((role) => role != UserRole.driver && role != UserRole.host && role != UserRole.chef && role != UserRole.photographer).map((role) {
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
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Colors.white : AppTheme.secondaryText,
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

class MockAuthSection extends ConsumerWidget {
  const MockAuthSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roleNotifier = ref.watch(roleToggleProvider.notifier);
    final currentRole = ref.watch(roleToggleProvider);
    final isLoggedIn = roleNotifier.isLoggedIn;

    return Container(
      margin: const EdgeInsets.all(AppTheme.spacing16),
      padding: const EdgeInsets.all(AppTheme.spacing20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.moroccoGreen.withValues(alpha: 0.1),
            AppTheme.moroccoGold.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: Border.all(
          color: AppTheme.moroccoGreen.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isLoggedIn ? Icons.person : Icons.person_outline,
                color: AppTheme.moroccoGreen,
              ),
              const SizedBox(width: AppTheme.spacing8),
              Text(
                '🧪 Demo Mode',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.moroccoGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Switch(
                value: isLoggedIn,
                onChanged: (value) => roleNotifier.toggleLogin(),
                activeColor: AppTheme.moroccoGreen,
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing12),
          Text(
            isLoggedIn 
                ? 'You\'re now logged in! Switch between Roles to see different features.'
                : 'Toggle this switch to simulate logging in and explore Role features.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.secondaryText,
            ),
          ),
          if (isLoggedIn) ...[
            const SizedBox(height: AppTheme.spacing16),
            Text(
              'Current User Type:',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.lightText,
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            Row(
              children: [
                Text(
                  currentRole.icon,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: AppTheme.spacing8),
                Text(
                  currentRole.label,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: currentRole.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}