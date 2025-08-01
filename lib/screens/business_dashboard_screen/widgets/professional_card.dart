import 'package:flutter/material.dart';
import 'package:deadhour/utils/app_theme.dart';


class ProfessionalCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final double? elevation;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;

  const ProfessionalCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.elevation,
    this.onTap,
    this.borderRadius,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final Widget cardWidget = Container(
      margin: margin ??
          const EdgeInsets.symmetric(
            horizontal: AppTheme.spacing16,
            vertical: AppTheme.spacing8,
          ),
      padding: padding ?? const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppTheme.cardBackground,
        borderRadius:
            borderRadius ?? BorderRadius.circular(AppTheme.radiusMedium),
        boxShadow: boxShadow ??
            [
              const BoxShadow(
                color: AppTheme.lightShadow,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
              const BoxShadow(
                color: AppTheme.mediumShadow,
                blurRadius: 16,
                offset: Offset(0, 4),
              ),
            ],
      ),
      child: child,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius:
            borderRadius ?? BorderRadius.circular(AppTheme.radiusMedium),
        child: cardWidget,
      );
    }

    return cardWidget;
  }
}

