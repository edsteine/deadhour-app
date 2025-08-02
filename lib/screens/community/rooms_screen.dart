import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deadhour/models/user.dart';
import 'package:deadhour/utils/error_handler.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/screens/community/widgets/room_interaction_helpers.dart';
import 'package:deadhour/screens/community/widgets/all_rooms_tab.dart';
import 'package:deadhour/screens/community/widgets/my_rooms_tab.dart';
import 'package:deadhour/screens/community/widgets/popular_rooms_tab.dart';
import 'package:deadhour/screens/community/widgets/business_rooms_tab.dart';
import 'package:deadhour/screens/community/widgets/guide_rooms_tab.dart';
import 'package:deadhour/utils/mock_data.dart';

class RoomsScreen extends ConsumerStatefulWidget {
  const RoomsScreen({super.key});

  @override
  ConsumerState<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends ConsumerState<RoomsScreen> {
  final String _selectedCity = 'Casablanca';
  String _selectedCategory = 'all';
  bool _showPrayerTimeAware = false;
  bool _showHalalOnly = false;
  final String _currentRoomType = 'all_rooms'; // Controlled by unified filter

  Widget _buildCurrentRoomView() {
    final user = ref.watch(userProvider);
    
    switch (_currentRoomType) {
      case 'all_rooms':
        return AllRoomsTab(
          selectedCategory: _selectedCategory,
          showPrayerTimeAware: _showPrayerTimeAware,
          showHalalOnly: _showHalalOnly,
          onRefresh: () =>
              RoomInteractionHelpers.handleRefresh(() => setState(() {})),
          onJoinRoom: (room) => RoomInteractionHelpers.joinRoom(context, ref,
              room, (r) => RoomInteractionHelpers.openRoom(context, r)),
        );
      case 'my_rooms':
        return MyRoomsTab(
          onOpenRoom: (room) => RoomInteractionHelpers.openRoom(context, room),
        );
      case 'popular':
        return PopularRoomsTab(
          onJoinRoom: (room) => RoomInteractionHelpers.joinRoom(context, ref,
              room, (r) => RoomInteractionHelpers.openRoom(context, r)),
        );
      case 'business':
        if (user?.hasRole('business') == true) {
          return const BusinessRoomsTab();
        }
        return _buildNoAccessView('Business rooms require a business role');
      case 'guide_network':
        if (user?.hasRole('guide') == true) {
          return const GuideRoomsTab();
        }
        return _buildNoAccessView('Guide network requires a guide role');
      default:
        return AllRoomsTab(
          selectedCategory: _selectedCategory,
          showPrayerTimeAware: _showPrayerTimeAware,
          showHalalOnly: _showHalalOnly,
          onRefresh: () =>
              RoomInteractionHelpers.handleRefresh(() => setState(() {})),
          onJoinRoom: (room) => RoomInteractionHelpers.joinRoom(context, ref,
              room, (r) => RoomInteractionHelpers.openRoom(context, r)),
        );
    }
  }
  
  Widget _buildNoAccessView(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.lock_outline,
            size: 64,
            color: AppTheme.secondaryText,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              color: AppTheme.secondaryText,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return ErrorBoundary(
      errorMessage: 'Unable to load community rooms',
      child: Scaffold(
        body: Column(
          children: [
            // Simple results header - all filtering moved to app bar
            _buildResultsHeader(user),
            // Room content controlled by unified filter in app bar
            Expanded(
              child: _buildCurrentRoomView(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          heroTag: 'roomsCreateRoomFAB',
          onPressed: () => RoomInteractionHelpers.showCreateRoomDialog(
              context, ref, _selectedCity),
          backgroundColor: AppTheme.moroccoGreen,
          icon: const Icon(Icons.add),
          label: const Text('Create Room'),
        ),
      ),
    );
  }

  Widget _buildResultsHeader(DeadHourUser? user) {
    // Calculate total filtered rooms count
    final totalRooms = _getFilteredRoomsCount();
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          Text(
            '$totalRooms rooms found${user?.name != null ? ' for ${user!.name}' : ''}',
            style: const TextStyle(
              fontSize: 16,
              color: AppTheme.primaryText,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          // Show active filters indicator if any are applied
          if (_selectedCategory != 'all' || _showPrayerTimeAware || _showHalalOnly)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Filters Active',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.moroccoGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () => _clearAllFilters(),
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: AppTheme.moroccoGreen,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  int _getFilteredRoomsCount() {
    var rooms = MockData.rooms;

    if (_selectedCategory != 'all') {
      rooms = rooms.where((room) => room.category == _selectedCategory).toList();
    }

    if (_showPrayerTimeAware) {
      rooms = rooms.where((room) => room.isPrayerTimeAware).toList();
    }
    if (_showHalalOnly) {
      rooms = rooms.where((room) => room.isHalalOnly).toList();
    }

    return rooms.length;
  }

  void _clearAllFilters() {
    setState(() {
      _selectedCategory = 'all';
      _showPrayerTimeAware = false;
      _showHalalOnly = false;
    });
  }

}

final userProvider = Provider<DeadHourUser?>((ref) {
  // In a real app, you would get the user from your authentication provider.
  // For now, we'll use the mock user.
  return MockData.currentUser;
});
