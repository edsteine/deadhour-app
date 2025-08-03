import '../../../models/room.dart';
import '../../../utils/mock_data.dart';

class RoomFilterLogic {
  static List<Room> getFilteredRooms({
    required String selectedCategory,
    required String selectedCity,
    required bool showPrayerTimeAware,
    required bool showHalalOnly,
  }) {
    var rooms = MockData.rooms;

    if (selectedCategory != 'all') {
      rooms = rooms.where((room) => room.category == selectedCategory).toList();
    }

    // Filter by city
    rooms = rooms.where((room) => room.city == selectedCity).toList();

    // Apply cultural filters
    if (showPrayerTimeAware) {
      rooms = rooms.where((room) => room.isPrayerTimeAware).toList();
    }
    if (showHalalOnly) {
      rooms = rooms.where((room) => room.isHalalOnly).toList();
    }

    return rooms;
  }
}
