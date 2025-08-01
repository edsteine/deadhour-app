import '../cultural/cultural_timing_widget.dart';
import '../../utils/performance_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Import modular widgets
import 'app_bar_actions_widget.dart';
import 'location_selector_widget.dart';
import 'role_switcher_widget.dart';
import 'app_bar_theme.dart' as custom;

/// Unified App Bar for consistent styling and functionality across all tabs
class DeadHourAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? customActions;
  final Widget? leading;
  final bool showBackButton;
  final bool showMenuDrawer;
  final bool showLocationSelector;
  final bool showNotifications;
  final bool showSearch;
  final bool showBusinessActions;
  final bool showTourismActions;
  final bool showRoleSwitcher;
  final bool showCulturalTiming;
  final String? selectedCity;
  final String? currentRole;
  final List<String>? availableRoles;
  final VoidCallback? onCityChanged;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onNotificationsPressed;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onCreateDealPressed;
  final Function(String)? onRoleChanged;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;

  const DeadHourAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.customActions,
    this.leading,
    this.showBackButton = false,
    this.showMenuDrawer = true,
    this.showLocationSelector = true,
    this.showNotifications = false,
    this.showSearch = false,
    this.showBusinessActions = false,
    this.showTourismActions = false,
    this.showRoleSwitcher = false,
    this.showCulturalTiming = false,
    this.selectedCity,
    this.currentRole,
    this.availableRoles,
    this.onCityChanged,
    this.onSearchPressed,
    this.onNotificationsPressed,
    this.onMenuPressed,
    this.onCreateDealPressed,
    this.onRoleChanged,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
  });

  @override
  ConsumerState<DeadHourAppBar> createState() => _DeadHourAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DeadHourAppBarState extends ConsumerState<DeadHourAppBar> {
  String _selectedCity = 'Casablanca';
  String _currentRole = 'consumer';

  @override
  void initState() {
    super.initState();
    _selectedCity = widget.selectedCity ?? 'Casablanca';
    _currentRole = widget.currentRole ?? 'consumer';
  }

  @override
  Widget build(BuildContext context) {
    final appBarTheme = _getAppBarTheme();
    
    return AppBar(
      title: _buildTitle(),
      backgroundColor: appBarTheme['backgroundColor'],
      foregroundColor: appBarTheme['foregroundColor'],
      elevation: widget.elevation,
      centerTitle: false,
      leading: _buildLeading(),
      actions: _buildActions(),
    );
  }

  Map<String, Color> _getAppBarTheme() {
    final backgroundColor = widget.backgroundColor ?? 
        custom.DeadHourAppBarTheme.getBackgroundColorByRole(_currentRole);
    final foregroundColor = widget.foregroundColor ?? 
        custom.DeadHourAppBarTheme.getForegroundColorByRole(_currentRole);
        
    return {
      'backgroundColor': backgroundColor,
      'foregroundColor': foregroundColor,
    };
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Main title with role switcher
        Row(
          children: [
            // Title text
            Text(
              widget.title,
              style: custom.DeadHourAppBarTheme.getTitleStyleByRole(_currentRole).copyWith(
                color: _getAppBarTheme()['foregroundColor'],
              ),
            ),
            
            // Role switcher if enabled
            if (widget.showRoleSwitcher && widget.availableRoles != null)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: RoleSwitcherWidget(
                  currentRole: _currentRole,
                  availableRoles: widget.availableRoles!,
                  onRoleChanged: (role) {
                    setState(() {
                      _currentRole = role;
                    });
                    if (widget.onRoleChanged != null) {
                      widget.onRoleChanged!(role);
                    }
                  },
                  textColor: _getAppBarTheme()['foregroundColor'],
                ),
              ),
          ],
        ),
        
        // Subtitle and location row
        if (widget.subtitle != null || 
            widget.showLocationSelector || 
            widget.showCulturalTiming)
          _buildSubtitleRow(),
      ],
    );
  }

  Widget _buildSubtitleRow() {
    return Row(
      children: [
        // Subtitle
        if (widget.subtitle != null)
          Flexible(
            child: Text(
              widget.subtitle!,
              style: custom.DeadHourAppBarTheme.getSubtitleStyleByRole(_currentRole).copyWith(
                color: _getAppBarTheme()['foregroundColor']?.withValues(alpha: 0.8),
              ),
            ),
          ),
        
        // Spacing if both subtitle and location/cultural
        if (widget.subtitle != null && 
            (widget.showLocationSelector || widget.showCulturalTiming))
          const SizedBox(width: 8),
        
        // Location selector
        if (widget.showLocationSelector)
          Flexible(
            child: LocationSelectorWidget(
              selectedCity: _selectedCity,
              onCityChanged: widget.onCityChanged,
              textColor: _getAppBarTheme()['foregroundColor'],
            ),
          ),
        
        // Spacing between location and cultural timing
        if (widget.showLocationSelector && widget.showCulturalTiming)
          const SizedBox(width: 8),
        
        // Cultural timing
        if (widget.showCulturalTiming)
          AppBarCulturalTimingWidget(
            showInAppBar: true,
            textColor: _getAppBarTheme()['foregroundColor'],
          ),
      ],
    );
  }

  Widget? _buildLeading() {
    if (widget.leading != null) return widget.leading;
    if (widget.showBackButton) return const BackButton();
    if (widget.showMenuDrawer) {
      return Builder(
        builder: (context) => IconButton(
          onPressed: () {
            PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(
            Icons.menu,
            color: _getAppBarTheme()['foregroundColor'],
          ),
          tooltip: 'Menu',
        ),
      );
    }
    return null;
  }

  List<Widget> _buildActions() {
    return [
      AppBarActionsWidget(
        customActions: widget.customActions,
        showBusinessActions: widget.showBusinessActions,
        showTourismActions: widget.showTourismActions,
        showSearch: widget.showSearch,
        showNotifications: widget.showNotifications,
        onCreateDealPressed: widget.onCreateDealPressed,
        onSearchPressed: widget.onSearchPressed,
        onNotificationsPressed: widget.onNotificationsPressed,
        onMenuPressed: widget.onMenuPressed,
        iconColor: _getAppBarTheme()['foregroundColor'],
      ),
    ];
  }
}