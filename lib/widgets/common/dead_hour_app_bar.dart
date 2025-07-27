import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/theme.dart';
import '../../utils/performance_utils.dart';
import '../../widgets/cultural/prayer_times_widget.dart';

// Unified App Bar for consistent styling and functionality across all tabs
class DeadHourAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
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
  final String? selectedCity;
  final VoidCallback? onCityChanged;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onNotificationsPressed;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onCreateDealPressed;
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
    this.showNotifications = true,
    this.showSearch = false,
    this.showBusinessActions = false,
    this.showTourismActions = false,
    this.selectedCity,
    this.onCityChanged,
    this.onSearchPressed,
    this.onNotificationsPressed,
    this.onMenuPressed,
    this.onCreateDealPressed,
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

  @override
  void initState() {
    super.initState();
    _selectedCity = widget.selectedCity ?? 'Casablanca';
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _buildTitle(),
      backgroundColor: widget.backgroundColor ?? AppTheme.moroccoGreen,
      foregroundColor: widget.foregroundColor ?? Colors.white,
      elevation: widget.elevation,
      centerTitle: false,
      leading: _buildLeading(),
      actions: _buildActions(),
    );
  }

  Widget _buildTitle() {
    if (widget.subtitle != null || widget.showLocationSelector) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: widget.foregroundColor ?? Colors.white,
            ),
          ),
          if (widget.subtitle != null)
            Text(
              widget.subtitle!,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: (widget.foregroundColor ?? Colors.white).withValues(alpha: 0.8),
              ),
            ),
          if (widget.showLocationSelector)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_on, 
                  size: 14,
                  color: widget.foregroundColor ?? Colors.white,
                ),
                const SizedBox(width: 4),
                Text(
                  _selectedCity,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: widget.foregroundColor ?? Colors.white,
                  ),
                ),
              ],
            ),
        ],
      );
    }

    return Text(
      widget.title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: widget.foregroundColor ?? Colors.white,
      ),
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
          icon: const Icon(Icons.menu),
          tooltip: 'Dev Menu',
        ),
      );
    }
    return null;
  }

  List<Widget> _buildActions() {
    List<Widget> actions = [];

    // Custom actions first
    if (widget.customActions != null) {
      actions.addAll(widget.customActions!);
    }

    // Location selector action
    if (widget.showLocationSelector) {
      actions.add(
        IconButton(
          onPressed: () {
            PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
            _showCitySelector();
          },
          icon: const Icon(Icons.tune),
          tooltip: 'Select City',
        ),
      );
    }

    // Business actions
    if (widget.showBusinessActions) {
      actions.add(
        IconButton(
          onPressed: () {
            PerformanceUtils.hapticFeedback(HapticFeedbackType.medium);
            if (widget.onCreateDealPressed != null) {
              widget.onCreateDealPressed!();
            } else {
              _showCreateDealAlert();
            }
          },
          icon: const Icon(Icons.add_business),
          tooltip: 'Create Deal',
        ),
      );
    }

    // Tourism actions
    if (widget.showTourismActions) {
      actions.add(
        IconButton(
          onPressed: () {
            PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
            if (widget.onMenuPressed != null) {
              widget.onMenuPressed!();
            } else {
              _showTourismMenu();
            }
          },
          icon: const Icon(Icons.more_vert),
          tooltip: 'Tourism Menu',
        ),
      );
    }

    // Search action
    if (widget.showSearch) {
      actions.add(
        IconButton(
          onPressed: () {
            PerformanceUtils.hapticFeedback(HapticFeedbackType.medium);
            if (widget.onSearchPressed != null) {
              widget.onSearchPressed!();
            } else {
              _showSearchDialog();
            }
          },
          icon: const Icon(Icons.search),
          tooltip: 'Search',
        ),
      );
    }

    // Notifications action
    if (widget.showNotifications) {
      actions.add(
        IconButton(
          onPressed: () {
            PerformanceUtils.hapticFeedback(HapticFeedbackType.light);
            if (widget.onNotificationsPressed != null) {
              widget.onNotificationsPressed!();
            } else {
              _showNotifications();
            }
          },
          icon: Stack(
            children: [
              const Icon(Icons.notifications_outlined),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          tooltip: 'Notifications',
        ),
      );
    }

    return actions;
  }

  void _showCitySelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select City',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...['Casablanca', 'Rabat', 'Marrakech', 'Fez', 'Tangier', 'Agadir'].map((city) {
              return ListTile(
                leading: const Icon(Icons.location_city),
                title: Text(city),
                trailing: _selectedCity == city ? const Icon(Icons.check, color: AppTheme.moroccoGreen) : null,
                onTap: () {
                  setState(() {
                    _selectedCity = city;
                  });
                  if (widget.onCityChanged != null) {
                    widget.onCityChanged!();
                  }
                  Navigator.pop(context);
                  PerformanceUtils.hapticFeedback(HapticFeedbackType.selection);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showNotifications() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notifications'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Prayer times widget at the top
            PrayerTimesWidget(isVisible: true),
            SizedBox(height: 16),
            // Regular notifications
            ListTile(
              leading: Icon(Icons.local_fire_department, color: AppColors.error),
              title: Text('New Flash Deal!'),
              subtitle: Text('50% off at Café Atlas - 2 hours left'),
              dense: true,
            ),
            ListTile(
              leading: Icon(Icons.people, color: AppColors.info),
              title: Text('Room Activity'),
              subtitle: Text('New message in Coffee Afternoon Deals'),
              dense: true,
            ),
            ListTile(
              leading: Icon(Icons.star, color: AppColors.warning),
              title: Text('Expert Request'),
              subtitle: Text('New tourist needs local guide assistance'),
              dense: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search'),
        content: const TextField(
          decoration: InputDecoration(
            hintText: 'Search for venues, deals, or experiences...', 
            prefixIcon: Icon(Icons.search),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  void _showCreateDealAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Deal'),
        content: const Text(
          'Are you a business owner? Switch to business mode to create deals for your venue.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to business role or profile
            },
            child: const Text('Go to Business'),
          ),
        ],
      ),
    );
  }

  void _showTourismMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Tourism Options',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              subtitle: const Text('العربية • Français • English'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Premium Features'),
              subtitle: const Text('Unlock expert connections'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Tourist Guide'),
              subtitle: const Text('How to use DeadHour in Morocco'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
