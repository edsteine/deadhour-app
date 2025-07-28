import 'package:flutter/material.dart';

class CommunityAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String selectedCity;
  final VoidCallback onCitySelectorPressed;
  final VoidCallback onRoomSearchPressed;

  const CommunityAppBar({
    super.key,
    required this.selectedCity,
    required this.onCitySelectorPressed,
    required this.onRoomSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Community Rooms',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              const Icon(Icons.location_on, size: 14),
              const SizedBox(width: 4),
              Text(
                selectedCity,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: onCitySelectorPressed,
          icon: const Icon(Icons.tune),
        ),
        IconButton(
          onPressed: onRoomSearchPressed,
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
