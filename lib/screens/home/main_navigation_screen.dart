import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';
import '../../utils/guest_mode.dart';
import '../../models/user.dart';

class MainNavigationScreen extends StatefulWidget {
  final Widget child;
  final DeadHourUser? user;

  const MainNavigationScreen({
    super.key,
    required this.child,
    this.user,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  List<NavigationItem> get _navigationItems {
    // Base navigation for all users
    List<NavigationItem> items = [
      NavigationItem(
        route: '/home',
        icon: Icons.home_outlined,
        activeIcon: Icons.home,
        label: 'Home',
      ),
      NavigationItem(
        route: '/community',
        icon: Icons.forum_outlined,
        activeIcon: Icons.forum,
        label: 'Community',
      ),
    ];

    // Add ADDON-specific navigation dynamically
    if (widget.user != null) {
      if (widget.user!.hasAddon(UserAddon.BUSINESS)) {
        items.add(NavigationItem(
          route: '/business',
          icon: Icons.business_outlined,
          activeIcon: Icons.business,
          label: 'Business',
        ));
      }
      
      if (widget.user!.hasAddon(UserAddon.GUIDE)) {
        items.add(NavigationItem(
          route: '/guide',
          icon: Icons.explore_outlined,
          activeIcon: Icons.explore,
          label: 'Guide',
        ));
      }
      
      if (widget.user!.hasAddon(UserAddon.PREMIUM)) {
        items.add(NavigationItem(
          route: '/premium',
          icon: Icons.star_outline,
          activeIcon: Icons.star,
          label: 'Premium',
        ));
      }
    }

    // Always add profile tab
    items.add(NavigationItem(
      route: '/profile',
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Profile',
    ));

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Guest mode banner
          if (GuestMode.isGuest) _buildGuestModeBanner(),
          // ADDON switching header (Instagram-inspired)
          if (widget.user != null && !GuestMode.isGuest) _buildAddonSwitchingHeader(),
          // Main content
          Expanded(child: widget.child),
        ],
      ),
      floatingActionButton: _buildAddonMarketplaceFAB(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildGuestModeBanner() {
    return Container(
      width: double.infinity,
      color: AppTheme.moroccoGold.withValues(alpha: 0.9),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'Browsing as Guest • Sign up to unlock all features',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              onPressed: () => context.go('/addon-marketplace'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _navigationItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isActive = _isRouteActive(item.route);

              return _buildNavigationItem(
                item: item,
                isActive: isActive,
                onTap: () => _onItemTapped(index, item.route),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationItem({
    required NavigationItem item,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.moroccoGreen.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? item.activeIcon : item.icon,
              color: isActive ? AppTheme.moroccoGreen : AppTheme.secondaryText,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? AppTheme.moroccoGreen : AppTheme.secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isRouteActive(String route) {
    final currentLocation = GoRouterState.of(context).uri.path;
    return currentLocation.startsWith(route);
  }

  void _onItemTapped(int index, String route) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
      context.go(route);
    }
  }
}

class NavigationItem {
  final String route;
  final IconData icon;
  final IconData activeIcon;
  final String label;

  NavigationItem({
    required this.route,
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

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

// Prayer Time Indicator Widget
class PrayerTimeIndicator extends StatelessWidget {
  final bool isVisible;

  const PrayerTimeIndicator({
    super.key,
    this.isVisible = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.prayerTime,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.access_time,
            color: Colors.white,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            'Prayer time - Community rooms paused',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}

// Floating Action Button for quick actions
class QuickActionFAB extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String tooltip;

  const QuickActionFAB({
    super.key,
    this.onPressed,
    this.icon = Icons.add,
    this.tooltip = 'Quick Action',
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: AppTheme.moroccoGreen,
      foregroundColor: Colors.white,
      tooltip: tooltip,
      child: Icon(icon),
    );
  }

  // Instagram-inspired ADDON switching header
  Widget _buildAddonSwitchingHeader() {
    if (widget.user == null || widget.user!.activeAddons.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // Active ADDONs indicator
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: widget.user!.activeAddons.map((addon) {
                    String label = addon.toString().split('.').last.toLowerCase();
                    String icon = _getAddonIcon(addon);
                    
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.moroccoGreen),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(icon, style: const TextStyle(fontSize: 14)),
                          const SizedBox(width: 4),
                          Text(
                            label.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.moroccoGreen,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            // Monthly revenue indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.moroccoGold.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '€${widget.user!.calculateMonthlyRevenue()}/mo',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.moroccoGold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getAddonIcon(UserAddon addon) {
    switch (addon) {
      case UserAddon.BUSINESS:
        return '🏢';
      case UserAddon.GUIDE:
        return '🌍';
      case UserAddon.PREMIUM:
        return '⭐';
      case UserAddon.DRIVER:
        return '🚗';
      case UserAddon.HOST:
        return '🏠';
      case UserAddon.CHEF:
        return '👨‍🍳';
      case UserAddon.PHOTOGRAPHER:
        return '📸';
    }
  }

  // ADDON marketplace FAB
  Widget _buildAddonMarketplaceFAB() {
    return FloatingActionButton(
      onPressed: () => context.push('/addon-marketplace'),
      backgroundColor: AppTheme.moroccoGreen,
      foregroundColor: Colors.white,
      tooltip: 'ADDON Marketplace',
      child: const Icon(Icons.add_business),
    );
  }
}
