import '../screens/business/services/analytics_data.dart';
import '../screens/community/models/room.dart';
import '../screens/community/services/room_data.dart';
import '../screens/deals/models/deal.dart';
import '../screens/deals/services/deal_data.dart';
import '../screens/profile/models/user.dart';
import '../screens/profile/services/user_data.dart';
import '../screens/venues/models/venue.dart';
import '../screens/venues/services/venue_data.dart';

/// Central mock data provider for DeadHour app
/// Aggregates all mock data categories in one convenient location
class MockData {
  // Venues
  static List<Venue> get venues => VenueData.venues;

  // Deals
  static List<Deal> get deals => DealData.deals;

  // Users
  static List<DeadHourUser> get users => UserData.users;
  static DeadHourUser get currentUser => UserData.currentUser;

  // Rooms
  static List<Room> get rooms => RoomData.rooms;

  // Analytics
  static Map<String, dynamic> get businessAnalytics => AnalyticsData.businessAnalytics;
  static Map<String, dynamic> get communityHealth => AnalyticsData.communityHealth;
  static Map<String, dynamic> get businessData => AnalyticsData.businessData;
}