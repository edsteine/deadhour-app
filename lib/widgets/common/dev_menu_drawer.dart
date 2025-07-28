import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/theme.dart';

class DevMenuDrawer extends StatelessWidget {
  const DevMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppTheme.spacing16),
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'DeadHour Dev Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing4),
                  Text(
                    'Route Testing & Navigation',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppTheme.spacing8),
                children: [
                  _buildCategorySection(
                    context,
                    'Authentication',
                    Icons.login,
                    [
                      DevRoute('Splash Screen', '/splash'),
                      DevRoute('Onboarding', '/onboarding'),
                      DevRoute('Role Marketplace', '/user-type'),
                      DevRoute('Login', '/login'),
                      DevRoute('Register', '/register'),
                    ],
                  ),
                  _buildCategorySection(
                    context,
                    'Home & Discovery',
                    Icons.home,
                    [
                      DevRoute('Home Screen', '/home'),
                      DevRoute('Deals Screen', '/home/deals'),
                      DevRoute('Venue Discovery', '/home/venues'),
                    ],
                  ),
                  _buildCategorySection(
                    context,
                    'Community',
                    Icons.people,
                    [
                      DevRoute('Rooms Screen', '/community'),
                    ],
                  ),
                  _buildCategorySection(
                    context,
                    'Business',
                    Icons.business,
                    [
                      DevRoute('Business Dashboard', '/business'),
                      DevRoute('Create Deal', '/business/create-deal'),
                      DevRoute(
                          'Revenue Optimization', '/business/optimization'),
                      DevRoute('Business Analytics', '/business/analytics'),
                    ],
                  ),
                  _buildCategorySection(
                    context,
                    'Tourism & Guides',
                    Icons.explore,
                    [
                      DevRoute('Tourism Screen', '/tourism'),
                      DevRoute('Local Expert', '/tourism/local-expert'),
                      DevRoute('Social Discovery', '/tourism/social-discovery'),
                      DevRoute('Guide Role', '/roles/guide'),
                    ],
                  ),
                  _buildCategorySection(
                    context,
                    'Profile & Settings',
                    Icons.person,
                    [
                      DevRoute('Profile Screen', '/profile'),
                      DevRoute('Settings', '/profile/settings'),
                    ],
                  ),
                  _buildCategorySection(
                    context,
                    'Admin & Future Features',
                    Icons.admin_panel_settings,
                    [
                      DevRoute('Network Effects Dashboard', '/admin'),
                      DevRoute('Role Switching (Future)', '/roles/switching'),
                      DevRoute('Premium Role (Future)', '/roles/premium'),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacing16),
                  _buildInfoSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(
    BuildContext context,
    String title,
    IconData icon,
    List<DevRoute> routes,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
      child: ExpansionTile(
        leading: Icon(icon, color: AppTheme.moroccoGreen),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        children:
            routes.map((route) => _buildRouteItem(context, route)).toList(),
      ),
    );
  }

  Widget _buildRouteItem(BuildContext context, DevRoute route) {
    final currentLocation = GoRouterState.of(context).uri.path;
    final isActive = currentLocation == route.path;

    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing24,
        vertical: AppTheme.spacing4,
      ),
      leading: Icon(
        Icons.navigate_next,
        size: 20,
        color: isActive ? AppTheme.moroccoGreen : AppTheme.secondaryText,
      ),
      title: Text(
        route.name,
        style: TextStyle(
          color: isActive ? AppTheme.moroccoGreen : AppTheme.primaryText,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      subtitle: Text(
        route.path,
        style: TextStyle(
          fontSize: 12,
          color: AppTheme.secondaryText.withValues(alpha: 0.7),
        ),
      ),
      trailing: isActive
          ? const Icon(
              Icons.circle,
              size: 8,
              color: AppTheme.moroccoGreen,
            )
          : null,
      onTap: () {
        try {
          if (route.path.contains('(Future)')) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${route.name} - Coming Soon'),
                backgroundColor: AppTheme.secondaryText,
              ),
            );
          } else {
            context.go(route.path);
            Navigator.of(context).pop(); // Close drawer
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Navigation error: ${route.path}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 16,
                color: AppTheme.secondaryText,
              ),
              SizedBox(width: AppTheme.spacing8),
              Text(
                'Development Info',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryText,
                ),
              ),
            ],
          ),
          SizedBox(height: AppTheme.spacing8),
          Text(
            '• Use this menu to test all app screens\n'
            '• Routes marked (Future) show coming soon message\n'
            '• Active route is highlighted in green\n'
            '• This menu is for development only',
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.secondaryText,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class DevRoute {
  final String name;
  final String path;

  DevRoute(this.name, this.path);
}
