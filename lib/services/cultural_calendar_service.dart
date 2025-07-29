/// Service for managing Islamic calendar integration and prayer times
/// Provides cultural timing awareness for Morocco market
class CulturalCalendarService {
  static final CulturalCalendarService _instance = CulturalCalendarService._internal();
  factory CulturalCalendarService() => _instance;
  CulturalCalendarService._internal();

  // Prayer times for Casablanca (example - would be API-driven in production)
  final Map<String, String> _prayerTimes = {
    'Fajr': '05:30',
    'Dhuhr': '13:15',
    'Asr': '16:45',
    'Maghrib': '19:20',
    'Isha': '20:35',
  };

  // Islamic holidays (example dates - would be calculated or API-driven)
  final Map<String, DateTime> _islamicHolidays = {
    'Eid al-Fitr': DateTime(2024, 4, 10),
    'Eid al-Adha': DateTime(2024, 6, 16),
    'Mawlid al-Nabi': DateTime(2024, 9, 27),
    'Laylat al-Qadr': DateTime(2024, 4, 5),
  };

  // Ramadan dates (example - would be calculated)
  final DateTime _ramadanStart = DateTime(2024, 3, 11);
  final DateTime _ramadanEnd = DateTime(2024, 4, 9);

  /// Get today's prayer times
  Map<String, String> getTodaysPrayerTimes() {
    return Map.from(_prayerTimes);
  }

  /// Get next upcoming prayer
  Map<String, String> getNextPrayer() {
    final now = DateTime.now();
    final currentTime = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    
    for (final entry in _prayerTimes.entries) {
      if (entry.value.compareTo(currentTime) > 0) {
        return {entry.key: entry.value};
      }
    }
    
    // If no more prayers today, return tomorrow's Fajr
    return {'Fajr (Tomorrow)': _prayerTimes['Fajr']!};
  }

  /// Check if given time conflicts with prayer time (within 30 minutes)
  bool isTimeConflictingWithPrayer(String time) {
    final timeToCheck = _timeStringToMinutes(time);
    
    for (final prayerTime in _prayerTimes.values) {
      final prayerMinutes = _timeStringToMinutes(prayerTime);
      final difference = (timeToCheck - prayerMinutes).abs();
      
      // Conflict if within 30 minutes of prayer time
      if (difference <= 30) {
        return true;
      }
    }
    
    return false;
  }

  /// Get prayer-friendly time suggestions
  List<String> getPrayerFriendlyTimes(List<String> availableTimes) {
    return availableTimes.where((time) => !isTimeConflictingWithPrayer(time)).toList();
  }

  /// Check if today is Ramadan
  bool isRamadan() {
    final now = DateTime.now();
    return now.isAfter(_ramadanStart) && now.isBefore(_ramadanEnd);
  }

  /// Check if today is an Islamic holiday
  bool isIslamicHoliday() {
    final today = DateTime.now();
    return _islamicHolidays.values.any((date) => 
      date.year == today.year && 
      date.month == today.month && 
      date.day == today.day
    );
  }

  /// Get today's Islamic holiday name if any
  String? getTodaysHoliday() {
    final today = DateTime.now();
    for (final entry in _islamicHolidays.entries) {
      if (entry.value.year == today.year && 
          entry.value.month == today.month && 
          entry.value.day == today.day) {
        return entry.key;
      }
    }
    return null;
  }

  /// Get Ramadan schedule adjustments
  Map<String, String> getRamadanSchedule() {
    if (!isRamadan()) return {};
    
    return {
      'Suhoor': '04:30', // Pre-dawn meal
      'Iftar': _prayerTimes['Maghrib']!, // Breaking fast at Maghrib
      'Tarawih': '21:00', // Special Ramadan prayers
    };
  }

  /// Get cultural business hour recommendations
  Map<String, String> getCulturalBusinessHours() {
    final recommendations = <String, String>{};
    
    if (isRamadan()) {
      recommendations['note'] = 'Ramadan schedule: Extended evening hours after Iftar';
      recommendations['recommended_hours'] = '10:00-16:00, 20:00-24:00';
    } else {
      recommendations['note'] = 'Avoid prayer times for optimal booking';
      recommendations['recommended_hours'] = '09:00-12:00, 14:00-16:00, 17:00-19:00, 21:00-23:00';
    }
    
    return recommendations;
  }

  /// Get prayer time warnings for booking
  List<String> getPrayerTimeWarnings(String bookingTime) {
    final warnings = <String>[];
    
    if (isTimeConflictingWithPrayer(bookingTime)) {
      final nextPrayer = getNextPrayer();
      warnings.add('Selected time is near ${nextPrayer.keys.first} prayer (${nextPrayer.values.first})');
      warnings.add('Consider booking 30 minutes before or after prayer time');
    }
    
    if (isRamadan()) {
      final ramadanSchedule = getRamadanSchedule();
      if (_isTimeNear(bookingTime, ramadanSchedule['Iftar']!)) {
        warnings.add('Booking near Iftar time - venue may have special Ramadan schedule');
      }
    }
    
    return warnings;
  }

  /// Helper: Convert time string to minutes since midnight
  int _timeStringToMinutes(String time) {
    final parts = time.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }

  /// Helper: Check if time is within 60 minutes of target
  bool _isTimeNear(String time1, String time2) {
    final minutes1 = _timeStringToMinutes(time1);
    final minutes2 = _timeStringToMinutes(time2);
    return (minutes1 - minutes2).abs() <= 60;
  }

  /// Get Islamic calendar date
  String getIslamicDate() {
    // Mock implementation - would use proper Islamic calendar calculation
    return '15 Rajab 1445 AH';
  }

  /// Get formatted prayer times for display
  List<Map<String, String>> getFormattedPrayerTimes() {
    return _prayerTimes.entries.map((entry) => {
      'name': entry.key,
      'time': entry.value,
      'arabic': _getPrayerArabicName(entry.key),
    }).toList();
  }

  String _getPrayerArabicName(String prayer) {
    switch (prayer) {
      case 'Fajr': return 'الفجر';
      case 'Dhuhr': return 'الظهر';
      case 'Asr': return 'العصر';
      case 'Maghrib': return 'المغرب';
      case 'Isha': return 'العشاء';
      default: return prayer;
    }
  }
}