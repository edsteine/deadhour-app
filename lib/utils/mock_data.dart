









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