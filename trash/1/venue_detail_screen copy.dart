import '../dev_menu/dead_hour_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/app_theme.dart';
import '../../utils/mock_data.dart';
import '../profile/services/cultural_calendar_service.dart';
import '../social/services/social_validation_service.dart';

// Import modular widgets
import 'widgets/venue_header_widget.dart';
import 'widgets/venue_booking_flow_widget.dart';
import 'widgets/venue_amenities_widget.dart';
import 'widgets/venue_deals_widget.dart';
import 'widgets/venue_reviews_widget.dart';
import 'widgets/venue_info_widget.dart';

class VenueDetailScreen extends ConsumerStatefulWidget {
  final String venueId;

  const VenueDetailScreen({
    super.key,
    required this.venueId,
  });

  @override
  ConsumerState<VenueDetailScreen> createState() => _VenueDetailScreenState();
}

class _VenueDetailScreenState extends ConsumerState<VenueDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isBookmarked = false;
  final _culturalCalendar = CulturalCalendarService();
  final _socialValidation = SocialValidationService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final venue = _getVenueById(widget.venueId);
    if (venue == null) {
      return const Scaffold(
        appBar: DeadHourAppBar(
          title: 'Venue Not Found',
          showBackButton: true,
        ),
        body: Center(
          child: Text('Venue not found'),
        ),
      );
    }

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            VenueHeaderWidget(
              venue: venue,
              isBookmarked: _isBookmarked,
              onBookmarkToggle: _toggleBookmark,
              onShare: _shareVenue,
              onCall: _callVenue,
              onDirections: _getDirections,
              onBook: _showBookingOptions,
            ),
          ];
        },
        body: Column(
          children: [
            // Venue basic info
            VenueBasicInfoWidget(
              venue: venue,
              onCall: _callVenue,
              onDirections: _getDirections,
              onBook: _showBookingOptions,
            ),
            
            // Tab bar
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                labelColor: AppTheme.moroccoGreen,
                unselectedLabelColor: AppTheme.secondaryText,
                indicatorColor: AppTheme.moroccoGreen,
                tabs: const [
                  Tab(text: 'Overview'),
                  Tab(text: 'Deals'),
                  Tab(text: 'Reviews'),
                  Tab(text: 'Info'),
                ],
              ),
            ),
            
            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  VenueAmenitiesWidget(
                    venue: venue,
                    culturalCalendar: _culturalCalendar,
                  ),
                  VenueDealsWidget(
                    venue: venue,
                    onDealTap: (deal) => VenueBookingFlowWidget.showDealDetails(context, deal, ref),
                  ),
                  VenueReviewsWidget(
                    venue: venue,
                    socialValidation: _socialValidation,
                  ),
                  VenueInfoWidget(
                    venue: venue,
                    culturalCalendar: _culturalCalendar,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Private utility methods
  dynamic _getVenueById(String venueId) {
    try {
      return MockData.venues.firstWhere((venue) => venue.id == venueId);
    } catch (e) {
      return null;
    }
  }

  void _toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isBookmarked ? 'Venue saved to bookmarks' : 'Venue removed from bookmarks',
        ),
        backgroundColor: _isBookmarked ? AppColors.success : AppTheme.secondaryText,
      ),
    );
  }

  void _shareVenue() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Venue shared successfully!'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _callVenue() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening phone app...'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _getDirections() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening maps app...'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _showBookingOptions() {
    VenueBookingFlowWidget.showBookingOptions(context, _tabController, ref);
  }
}