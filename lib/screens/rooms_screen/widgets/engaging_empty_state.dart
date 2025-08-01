

import 'package:flutter/material.dart';


import 'package:deadhour/utils/app_theme.dart';


class EngagingEmptyState extends StatelessWidget {
  final EmptyStateType type;
  final String? customTitle;
  final String? customDescription;
  final VoidCallback? primaryAction;
  final String? primaryActionText;
  final VoidCallback? secondaryAction;
  final String? secondaryActionText;
  final Widget? customIllustration;

  const EngagingEmptyState({
    super.key,
    required this.type,
    this.customTitle,
    this.customDescription,
    this.primaryAction,
    this.primaryActionText,
    this.secondaryAction,
    this.secondaryActionText,
    this.customIllustration,
  });

  @override
  Widget build(BuildContext context) {
    final config = _getEmptyStateConfig(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration
            customIllustration ?? _buildDefaultIllustration(config),
            const SizedBox(height: 24),

            // Title
            Text(
              customTitle ?? config.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryText,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              customDescription ?? config.description,
              style: const TextStyle(
                fontSize: 16,
                color: AppTheme.secondaryText,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Actions
            _buildActions(config),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultIllustration(EmptyStateConfig config) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: config.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(60),
      ),
      child: Center(
        child: Text(
          config.emoji,
          style: const TextStyle(fontSize: 48),
        ),
      ),
    );
  }

  Widget _buildActions(EmptyStateConfig config) {
    return Column(
      children: [
        // Primary action
        if (config.primaryActionText != null && config.primaryAction != null)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: primaryAction ?? config.primaryAction,
              icon: Icon(config.primaryIcon),
              label: Text(primaryActionText ?? config.primaryActionText!),
              style: ElevatedButton.styleFrom(
                backgroundColor: config.color,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

        // Secondary action
        if (config.secondaryActionText != null &&
            config.secondaryAction != null) ...[
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: secondaryAction ?? config.secondaryAction,
              icon: Icon(config.secondaryIcon),
              label: Text(secondaryActionText ?? config.secondaryActionText!),
              style: OutlinedButton.styleFrom(
                foregroundColor: config.color,
                side: BorderSide(color: config.color),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],

        // Additional helpful tips
        if (config.helpfulTips.isNotEmpty) ...[
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.lightbulb_outline,
                        size: 20, color: AppTheme.moroccoGreen),
                    SizedBox(width: 8),
                    Text(
                      'Quick Tips',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.moroccoGreen,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ...config.helpfulTips.map((tip) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• ',
                              style: TextStyle(color: AppTheme.secondaryText)),
                          Expanded(
                            child: Text(
                              tip,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppTheme.secondaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ],
    );
  }

  EmptyStateConfig _getEmptyStateConfig(BuildContext context) {
    final isGuest = GuestMode.isGuest;
    final isAuthenticated = AuthService().isAuthenticated;

    switch (type) {
      case EmptyStateType.noDeals:
        return EmptyStateConfig(
          emoji: '🎯',
          title: 'No deals yet!',
          description: isGuest
              ? 'Create an account to unlock exclusive dead hour deals from local businesses.'
              : 'Be the first to discover amazing deals during dead hours in your area.',
          color: AppTheme.moroccoGreen,
          primaryActionText: isGuest ? 'Create Account' : 'Explore Venues',
          primaryIcon: isGuest ? Icons.person_add : Icons.search,
          primaryAction: () =>
              _handleAuthAction(context, '/register', '/venues'),
          secondaryActionText: isGuest ? 'Continue as Guest' : 'Notify Me',
          secondaryIcon: isGuest ? Icons.visibility : Icons.notifications,
          secondaryAction: () => _handleSecondaryAction(context, isGuest),
          helpfulTips: [
            'Deals are usually posted 1-2 hours before dead hours',
            'Follow your favorite venues for instant notifications',
            'Check back during 14:00-16:00 for afternoon deals',
          ],
        );

      case EmptyStateType.noRooms:
        return EmptyStateConfig(
          emoji: '💬',
          title: 'No community rooms yet',
          description:
              'Community rooms are where deals come alive! Join conversations, get recommendations, and discover hidden gems.',
          color: Colors.purple,
          primaryActionText: isAuthenticated ? 'Create Room' : 'Join Community',
          primaryIcon: isAuthenticated ? Icons.add : Icons.people,
          primaryAction: () =>
              _handleAuthAction(context, '/register', '/create-room'),
          secondaryActionText: 'Browse Popular',
          secondaryIcon: Icons.trending_up,
          secondaryAction: () => _navigateToPopular(context),
          helpfulTips: [
            'Rooms are organized by category (Food, Entertainment, etc.)',
            'Share photos and experiences to help others',
            'Ask locals for insider tips and recommendations',
          ],
        );

      case EmptyStateType.noBookings:
        return EmptyStateConfig(
          emoji: '📅',
          title: 'No bookings yet',
          description: isGuest
              ? 'Sign up to start booking amazing deals and track your experiences.'
              : 'Start exploring deals and make your first booking!',
          color: Colors.blue,
          primaryActionText: isGuest ? 'Create Account' : 'Find Deals',
          primaryIcon: isGuest ? Icons.person_add : Icons.local_offer,
          primaryAction: () =>
              _handleAuthAction(context, '/register', '/deals'),
          secondaryActionText: 'Browse Venues',
          secondaryIcon: Icons.store,
          secondaryAction: () => Navigator.pushNamed(context, '/venues'),
          helpfulTips: [
            'Book during dead hours for the best discounts',
            'Check venue reviews before booking',
            'Save favorites for quick access later',
          ],
        );

      case EmptyStateType.noSearchResults:
        return EmptyStateConfig(
          emoji: '🔍',
          title: 'No results found',
          description:
              'Try adjusting your search terms or filters. The perfect deal might be just a keyword away!',
          color: Colors.orange,
          primaryActionText: 'Clear Filters',
          primaryIcon: Icons.clear_all,
          primaryAction: () => _clearSearchFilters(context),
          secondaryActionText: 'Browse All',
          secondaryIcon: Icons.explore,
          secondaryAction: () => _browseAll(context),
          helpfulTips: [
            'Try broader search terms',
            'Check spelling and remove filters',
            'Search by neighborhood or cuisine type',
          ],
        );

      case EmptyStateType.noCommunityActivity:
        return EmptyStateConfig(
          emoji: '🌟',
          title: 'Be the conversation starter!',
          description:
              'This community is waiting for someone like you to share the first experience.',
          color: AppTheme.moroccoGreen,
          primaryActionText:
              isAuthenticated ? 'Share Experience' : 'Join Community',
          primaryIcon: isAuthenticated ? Icons.edit : Icons.person_add,
          primaryAction: () =>
              _handleAuthAction(context, '/register', '/share-experience'),
          secondaryActionText: 'Ask Question',
          secondaryIcon: Icons.help_outline,
          secondaryAction: () => _askQuestion(context),
          helpfulTips: [
            'Share photos of your recent visits',
            'Ask locals for recommendations',
            'Rate and review your experiences',
          ],
        );

      case EmptyStateType.noBusinessDeals:
        return EmptyStateConfig(
          emoji: '💰',
          title: 'Turn dead hours into profit',
          description:
              'Create your first deal and start filling those empty tables during slow periods.',
          color: Colors.green,
          primaryActionText: 'Create Deal',
          primaryIcon: Icons.add_business,
          primaryAction: () => Navigator.pushNamed(context, '/create-deal'),
          secondaryActionText: 'View Analytics',
          secondaryIcon: Icons.analytics,
          secondaryAction: () =>
              Navigator.pushNamed(context, '/business-analytics'),
          helpfulTips: [
            'Optimal discount: 30-40% for dead hours',
            'Best times: 14:00-16:00 and 21:00-23:00',
            'Community validation increases bookings by 60%',
          ],
        );

      case EmptyStateType.networkError:
        return EmptyStateConfig(
          emoji: '📶',
          title: 'Connection problem',
          description:
              'Check your internet connection and try again. Your deals are waiting!',
          color: Colors.red,
          primaryActionText: 'Retry',
          primaryIcon: Icons.refresh,
          primaryAction: () => _retryConnection(context),
          secondaryActionText: 'Offline Mode',
          secondaryIcon: Icons.offline_bolt,
          secondaryAction: () => _enableOfflineMode(context),
          helpfulTips: [
            'Some features work offline',
            'Saved content is still accessible',
            'Your bookings are automatically synced when connected',
          ],
        );

      default:
        return EmptyStateConfig(
          emoji: '🤔',
          title: 'Nothing here yet',
          description: 'This section is waiting for some content.',
          color: AppTheme.secondaryText,
          primaryActionText: 'Explore',
          primaryIcon: Icons.explore,
          primaryAction: () => Navigator.pushNamed(context, '/home'),
          helpfulTips: [],
        );
    }
  }

  void _handleAuthAction(
      BuildContext context, String guestRoute, String authRoute) {
    if (GuestMode.isGuest) {
      Navigator.pushNamed(context, guestRoute);
    } else {
      Navigator.pushNamed(context, authRoute);
    }
  }

  void _handleSecondaryAction(BuildContext context, bool isGuest) {
    if (isGuest) {
      Navigator.pushNamed(context, '/home');
    } else {
      _showNotificationSetup(context);
    }
  }

  void _navigateToPopular(BuildContext context) {
    Navigator.pushNamed(context, '/popular-rooms');
  }

  void _clearSearchFilters(BuildContext context) {
    Navigator.pop(context, 'clear_filters');
  }

  void _browseAll(BuildContext context) {
    Navigator.pushNamed(context, '/browse-all');
  }

  void _askQuestion(BuildContext context) {
    Navigator.pushNamed(context, '/ask-question');
  }

  void _retryConnection(BuildContext context) {
    // Trigger retry mechanism
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Retrying connection...'),
        backgroundColor: AppTheme.moroccoGreen,
      ),
    );
  }

  void _enableOfflineMode(BuildContext context) {
    Navigator.pushNamed(context, '/offline-mode');
  }

  void _showNotificationSetup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Stay Updated'),
        content: const Text(
            'Enable notifications to get alerted when new deals matching your interests are posted.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Enable notifications
            },
            child: const Text('Enable'),
          ),
        ],
      ),
    );
  }
}

