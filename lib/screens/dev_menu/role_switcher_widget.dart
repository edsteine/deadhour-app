import '../../utils/performance_utils.dart';
import 'package:flutter/material.dart';
import 'role_switcher_bottom_sheet.dart';


/// Intuitive role switcher widget for app bar with familiar interface patterns
class RoleSwitcherWidget extends StatelessWidget {
  final String currentRole;
  final List<String> availableRoles;
  final Function(String) onRoleChanged;
  final Color? textColor;
  final Color? backgroundColor;

  const RoleSwitcherWidget({
    super.key,
    required this.currentRole,
    required this.availableRoles,
    required this.onRoleChanged,
    this.textColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (availableRoles.length <= 1) {
      return Text(
        _getRoleDisplayName(currentRole),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textColor ?? Colors.white,
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
        _showRoleSwitcher(context);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _getRoleDisplayName(currentRole),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor ?? Colors.white,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.keyboard_arrow_down,
            size: 18,
            color: textColor ?? Colors.white,
          ),
        ],
      ),
    );
  }

  String _getRoleDisplayName(String role) {
    switch (role.toLowerCase()) {
      case 'consumer':
        return 'Explore';
      case 'business':
        return 'Business';
      case 'guide':
        return 'Guide';
      case 'tourism':
      case 'tourist':
        return 'Tourism';
      case 'premium':
        return 'Premium';
      default:
        return role;
    }
  }

  void _showRoleSwitcher(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => RoleSwitcherBottomSheet(
        currentRole: currentRole,
        availableRoles: availableRoles,
        onRoleChanged: onRoleChanged,
      ),
    );
  }
}

