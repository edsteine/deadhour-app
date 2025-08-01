import 'package:flutter/material.dart';
import 'cultural_info_bottom_sheet.dart';


/// Cultural timing widget with prayer times and Islamic calendar integration
class AppBarCulturalTimingWidget extends StatelessWidget {
  final bool showInAppBar;
  final Color? textColor;
  final double fontSize;

  const AppBarCulturalTimingWidget({
    super.key,
    this.showInAppBar = false,
    this.textColor,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    if (!showInAppBar) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () => _showCulturalInfo(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.access_time,
            size: 14,
            color: textColor ?? Colors.white,
          ),
          const SizedBox(width: 4),
          Text(
            _getNextPrayerInfo(),
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w400,
              color: textColor ?? Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  String _getNextPrayerInfo() {
    // Mock prayer time - in real app, this would calculate based on location and time
    final now = DateTime.now();
    final hour = now.hour;

    if (hour < 5) return 'Fajr 05:30';
    if (hour < 12) return 'Dhuhr 12:45';
    if (hour < 15) return 'Asr 15:20';
    if (hour < 18) return 'Maghrib 18:42';
    if (hour < 20) return 'Isha 20:15';
    return 'Fajr 05:30'; // Next day
  }

  void _showCulturalInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const CulturalInfoBottomSheet(),
    );
  }
}

