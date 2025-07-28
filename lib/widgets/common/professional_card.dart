import 'package:flutter/material.dart';
import '../../utils/theme.dart';

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
    Widget cardWidget = Container(
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

class ProfessionalStatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color? valueColor;
  final VoidCallback? onTap;

  const ProfessionalStatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    this.valueColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ProfessionalCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing8),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppTheme.spacing12),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.secondaryText,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),
          Text(
            value,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: valueColor ?? AppTheme.primaryText,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppTheme.spacing4),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.lightText,
                ),
          ),
        ],
      ),
    );
  }
}

class ProfessionalActionCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;
  final String? actionText;
  final Widget? trailing;

  const ProfessionalActionCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.onTap,
    this.actionText,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ProfessionalCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: AppTheme.spacing16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: AppTheme.spacing4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.secondaryText,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: AppTheme.spacing12),
            trailing!,
          ] else if (actionText != null) ...[
            const SizedBox(width: AppTheme.spacing12),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacing12,
                vertical: AppTheme.spacing8,
              ),
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
              ),
              child: Text(
                actionText!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.moroccoGreen,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class ProfessionalGradientCard extends StatelessWidget {
  final Widget child;
  final List<Color> colors;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;

  const ProfessionalGradientCard({
    super.key,
    required this.child,
    required this.colors,
    this.padding,
    this.margin,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ??
          const EdgeInsets.symmetric(
            horizontal: AppTheme.spacing16,
            vertical: AppTheme.spacing8,
          ),
      padding: padding ?? const EdgeInsets.all(AppTheme.spacing20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius:
            borderRadius ?? BorderRadius.circular(AppTheme.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: colors.first.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
