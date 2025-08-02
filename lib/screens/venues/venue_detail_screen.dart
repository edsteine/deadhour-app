import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/utils/mock_data.dart';
import 'package:deadhour/models/venue.dart';
import 'package:deadhour/widgets/common/dead_hour_app_bar.dart';
import 'package:deadhour/services/cultural_calendar_service.dart';
import 'package:deadhour/services/social_validation_service.dart';
import 'package:deadhour/screens/venues/widgets/venue_header_widget.dart';
import 'package:deadhour/screens/venues/widgets/venue_overview_tab.dart';
import 'package:deadhour/screens/venues/widgets/venue_deals_tab.dart';
import 'package:deadhour/screens/venues/widgets/venue_reviews_tab.dart';
import 'package:deadhour/screens/venues/widgets/venue_info_tab.dart';

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
            VenueHeaderWidget(venue: venue),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: AppTheme.moroccoGreen,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: AppTheme.moroccoGreen,
                  tabs: const [
                    Tab(text: 'Overview'),
                    Tab(text: 'Deals'),
                    Tab(text: 'Reviews'),
                    Tab(text: 'Info'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            VenueOverviewTab(
              venue: venue,
              culturalCalendar: _culturalCalendar,
              socialValidation: _socialValidation,
            ),
            VenueDealsTab(venue: venue),
            VenueReviewsTab(venue: venue),
            VenueInfoTab(venue: venue),
          ],
        ),
      ),
    );
  }

  Venue? _getVenueById(String id) {
    try {
      return MockData.venues.firstWhere((venue) => venue.id == id);
    } catch (e) {
      return null;
    }
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}