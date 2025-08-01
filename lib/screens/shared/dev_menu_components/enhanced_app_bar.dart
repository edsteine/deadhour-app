import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:deadhour/utils/app_theme.dart';


class EnhancedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final bool centerTitle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final bool showGradient;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;

  const EnhancedAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
    this.leading,
    this.showBackButton = false,
    this.onBackPressed,
    this.centerTitle = false,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.showGradient = false,
    this.flexibleSpace,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    final defaultBackgroundColor =
        backgroundColor ?? (showGradient ? null : AppTheme.cardColor);
    final defaultForegroundColor = foregroundColor ?? AppTheme.primaryText;

    return AppBar(
      title: _buildTitle(),
      leading: _buildLeading(context),
      actions: actions,
      centerTitle: centerTitle,
      backgroundColor: defaultBackgroundColor,
      foregroundColor: defaultForegroundColor,
      elevation: elevation,
      systemOverlayStyle: _getSystemOverlayStyle(),
      flexibleSpace: showGradient ? _buildGradientBackground() : flexibleSpace,
      bottom: bottom,
      shape: elevation > 0
          ? const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
            )
          : null,
    );
  }

  Widget _buildTitle() {
    if (subtitle != null) {
      return Column(
        crossAxisAlignment:
            centerTitle ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: showGradient ? Colors.white : AppTheme.primaryText,
            ),
          ),
          Text(
            subtitle!,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: showGradient
                  ? Colors.white.withValues(alpha: 0.9)
                  : AppTheme.secondaryText,
            ),
          ),
        ],
      );
    }

    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: showGradient ? Colors.white : AppTheme.primaryText,
      ),
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) return leading;

    if (showBackButton) {
      return IconButton(
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
        icon: Icon(
          Icons.arrow_back_ios,
          color: showGradient ? Colors.white : AppTheme.primaryText,
        ),
      );
    }

    return null;
  }

  Widget _buildGradientBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.moroccoGreen, AppTheme.darkGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  SystemUiOverlayStyle _getSystemOverlayStyle() {
    if (showGradient) {
      return SystemUiOverlayStyle.light;
    }
    return SystemUiOverlayStyle.dark;
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );
}

