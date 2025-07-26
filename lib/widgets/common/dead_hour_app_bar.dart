import 'package:flutter/material.dart';
import 'package:deadhour/utils/theme.dart';

// Custom App Bar for consistent styling across screens  
class DeadHourAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;

  const DeadHourAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.showBackButton = false,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: foregroundColor ?? Colors.white,
        ),
      ),
      backgroundColor: backgroundColor ?? AppTheme.moroccoGreen,
      foregroundColor: foregroundColor ?? Colors.white,
      elevation: elevation,
      centerTitle: true,
      leading: leading ?? (showBackButton ? const BackButton() : null),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
