import '../models/room.dart';
import '../../../utils/mock_data.dart';

class RoomFilterLogic {
  static List<Room> getFilteredRooms({
    required String selectedCategory,
    String? selectedCity,
    required bool showPrayerTimeAware,
    required bool showHalalOnly,
  }) {
    var rooms = MockData.rooms;

    // Filter by category
    if (selectedCategory != 'all') {
      rooms = rooms.where((room) => room.category == selectedCategory).toList();
    }

    // Filter by city (optional)
    if (selectedCity != null && selectedCity.isNotEmpty) {
      rooms = rooms.where((room) => room.city == selectedCity).toList();
    }

    // Apply cultural filters
    if (showPrayerTimeAware) {
      rooms = rooms.where((room) => room.isPrayerTimeAware).toList();
    }
    if (showHalalOnly) {
      rooms = rooms.where((room) => room.isHalalOnly).toList();
    }

    return rooms;
  }

  /// Get rooms for specific role-based filtering
  static List<Room> getBusinessRooms({
    String? selectedCity,
    bool showPrayerTimeAware = false,
    bool showHalalOnly = false,
  }) {
    return getFilteredRooms(
      selectedCategory: 'business',
      selectedCity: selectedCity,
      showPrayerTimeAware: showPrayerTimeAware,
      showHalalOnly: showHalalOnly,
    );
  }

  /// Get rooms for guide role
  static List<Room> getGuideRooms({
    String? selectedCity,
    bool showPrayerTimeAware = false,
    bool showHalalOnly = false,
  }) {
    return getFilteredRooms(
      selectedCategory: 'tourism',
      selectedCity: selectedCity,
      showPrayerTimeAware: showPrayerTimeAware,
      showHalalOnly: showHalalOnly,
    );
  }

  /// Get popular rooms (based on member count or activity)
  static List<Room> getPopularRooms({
    String? selectedCity,
    bool showPrayerTimeAware = false,
    bool showHalalOnly = false,
  }) {
    var rooms = getFilteredRooms(
      selectedCategory: 'all',
      selectedCity: selectedCity,
      showPrayerTimeAware: showPrayerTimeAware,
      showHalalOnly: showHalalOnly,
    );
    
    // Sort by member count (using isPopular as proxy for now)
    rooms.sort((a, b) {
      // Popular rooms first, then by name
      int popularCompare = (b.isPopular ? 1 : 0).compareTo(a.isPopular ? 1 : 0);
      if (popularCompare != 0) return popularCompare;
      return a.name.compareTo(b.name);
    });
    return rooms.take(10).toList(); // Top 10 popular rooms
  }
}
