
import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';



/// Current active roles display with monthly value calculation
class RoleCurrentRolesSection extends StatelessWidget {
  final Set<UserRole> activeRoles;
  final UserRole primaryRole;

  const RoleCurrentRolesSection({
    super.key,
    required this.activeRoles,
    required this.primaryRole,
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
                  Icons.account_circle,
                  color: AppTheme.moroccoGreen,
                  size: 24,
                ),
                SizedBox(width: AppTheme.spacing12),
                Text(
                  'Your Active Roles',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            // Active roles display
            Wrap(
              spacing: AppTheme.spacing8,
              runSpacing: AppTheme.spacing8,
              children: activeRoles.map((role) {
                final roleInfo = RoleData.roleData[role]!;
                final isPrimary = role == primaryRole;
                
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacing12,
                    vertical: AppTheme.spacing8,
                  ),
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        roleInfo['icon'] as IconData,
                        size: 16,
                        color: roleInfo['color'] as Color,
                      ),
                      const SizedBox(width: AppTheme.spacing8),
                      Text(
                        roleInfo['title'] as String,
                        style: TextStyle(
                          fontWeight: isPrimary ? FontWeight.bold : FontWeight.w500,
                          color: isPrimary 
                              ? (roleInfo['color'] as Color)
                              : Colors.grey[700],
                        ),
                      ),
                      if (isPrimary) ...[
                        const SizedBox(width: AppTheme.spacing4),
                        Icon(
                          Icons.star,
                          size: 12,
                          color: roleInfo['color'] as Color,
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),
            
            const SizedBox(height: AppTheme.spacing16),
            
            // Revenue and benefits summary
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing12),
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.monetization_on, color: AppTheme.moroccoGreen),
                      const SizedBox(width: AppTheme.spacing8),
                      const Text(
                        'Monthly Value',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Text(
                        '€${_calculateTotalMonthlyValue()}',
                        style: const TextStyle(
                          color: AppTheme.moroccoGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacing8),
                  Text(
                    'You\'re maximizing value with ${activeRoles.length} role${activeRoles.length > 1 ? 's' : ''}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _calculateTotalMonthlyValue() {
    int total = 0;
    for (final role in activeRoles) {
      final price = RoleData.roleData[role]!['price'] as String;
      if (price.contains('€')) {
        final amount = int.tryParse(price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
        total += amount;
      }
    }
    
    // Apply multi-role discount
    if (activeRoles.length > 1) {
      total = (total * 0.9).round(); // 10% multi-role discount
    }
    
    return total;
  }
}