import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



class RoomChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Room room;
  final Function() onShowRoomInfo;
  final Function() onShowRoomMenu;
  final Color Function(String) getCategoryColor;

  const RoomChatAppBar({
    super.key,
    required this.room,
    required this.onShowRoomInfo,
    required this.onShowRoomMenu,
    required this.getCategoryColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: const Icon(Icons.arrow_back),
      ),
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: getCategoryColor(room.category).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                room.categoryIcon,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  room.displayName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${room.onlineCount} online • ${room.memberCount} members',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: onShowRoomInfo,
          icon: const Icon(Icons.info_outline),
        ),
        IconButton(
          onPressed: onShowRoomMenu,
          icon: const Icon(Icons.more_vert),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
