import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../utils/performance_utils.dart';
import '../utils/app_logger.dart';
import 'app_performance_service.dart';
import 'cultural/next_prayer_info.dart';
import 'cultural/ramadan_schedule.dart';
import 'cultural/cultural_holiday.dart';
import 'cultural/halal_status.dart';
import 'cultural/prayer_calculator.dart';

// Morocco Cultural Service for DeadHour App
// Handles prayer times, Ramadan mode, halal certification, and cultural considerations
class MoroccoCulturalService extends ChangeNotifier {
  static final MoroccoCulturalService _instance =
      MoroccoCulturalService._internal();
  factory MoroccoCulturalService() => _instance;
  MoroccoCulturalService._internal();

  bool _isInitialized = false;
  bool _isRamadanMode = false;
  String _currentCity = 'Casablanca';
  Locale _currentLocale = const Locale('en', 'US');
  Map<String, DateTime> _todaysPrayerTimes = {};
  Timer? _prayerNotificationTimer;

  // Prayer times cache
  final Map<String, Map<String, DateTime>> _prayerTimesCache = {};

  // Getters
  bool get isInitialized => _isInitialized;
  bool get isRamadanMode => _isRamadanMode;
  String get currentCity => _currentCity;
  Locale get currentLocale => _currentLocale;
  bool get isArabicLocale => _currentLocale.languageCode == 'ar';
  bool get isFrenchLocale => _currentLocale.languageCode == 'fr';
  Map<String, DateTime> get todaysPrayerTimes => _todaysPrayerTimes;

  // Initialize cultural service
  Future<void> initialize() async {
    try {
      // Use lightweight initialization in debug mode for faster startup
      if (kDebugMode) {
        await _initializeLightweight();
      } else {
        await _initializeFull();
      }

      _isInitialized = true;
      AppLogger.serviceInit('MoroccoCulturalService');
    } catch (e) {
      AppLogger.serviceInit('MoroccoCulturalService', success: false);
      AppLogger.error('MoroccoCulturalService initialization error', error: e);
      rethrow;
    }
  }

  // Lightweight initialization for development
  Future<void> _initializeLightweight() async {
    // Basic setup without heavy computations
    _currentCity = 'Casablanca';
    _currentLocale = const Locale('en', 'US');
    
    // Mock prayer times for development
    final now = DateTime.now();
    _todaysPrayerTimes = {
      'Fajr': DateTime(now.year, now.month, now.day, 5, 30),
      'Dhuhr': DateTime(now.year, now.month, now.day, 12, 30),
      'Asr': DateTime(now.year, now.month, now.day, 15, 30),
      'Maghrib': DateTime(now.year, now.month, now.day, 18, 30),
      'Isha': DateTime(now.year, now.month, now.day, 20),
    };
  }

  // Full initialization for production
  Future<void> _initializeFull() async {
    // Load user preferences
    await _loadUserPreferences();

    // Initialize prayer times
    await _initializePrayerTimes();

    // Check if it's Ramadan
    await _checkRamadanStatus();

    // Setup prayer notifications
    _setupPrayerNotifications();
  }

  // Set user city
  Future<void> setCity(String city) async {
    if (_currentCity != city) {
      _currentCity = city;
      await _saveCityPreference(city);
      await _updatePrayerTimes();
      notifyListeners();
    }
  }

  // Set app locale
  Future<void> setLocale(Locale locale) async {
    if (_currentLocale != locale) {
      _currentLocale = locale;
      await _saveLocalePreference(locale);
      notifyListeners();
    }
  }

  // Get prayer times for specific date
  Map<String, DateTime> getPrayerTimes({DateTime? date, String? city}) {
    final targetDate = date ?? DateTime.now();
    final targetCity = city ?? _currentCity;
    final cacheKey =
        '${targetCity}_${targetDate.toIso8601String().split('T')[0]}';

    return _prayerTimesCache[cacheKey] ??
        PrayerCalculator.generatePrayerTimes(targetDate, targetCity);
  }

  // Get next prayer info
  NextPrayerInfo getNextPrayer() {
    final now = DateTime.now();
    final prayers = _todaysPrayerTimes;

    for (final entry in prayers.entries) {
      if (entry.value.isAfter(now)) {
        final timeUntil = entry.value.difference(now);
        return NextPrayerInfo(
          name: entry.key,
          time: entry.value,
          timeUntil: timeUntil,
          isNext: true,
        );
      }
    }

    // If no prayer left today, get first prayer of tomorrow
    final tomorrowPrayers =
        getPrayerTimes(date: now.add(const Duration(days: 1)));
    final firstPrayer = tomorrowPrayers.entries.first;

    return NextPrayerInfo(
      name: firstPrayer.key,
      time: firstPrayer.value,
      timeUntil: firstPrayer.value.difference(now),
      isNext: false,
    );
  }

  // Check if current time is prayer time
  bool isPrayerTime({Duration tolerance = const Duration(minutes: 15)}) {
    final now = DateTime.now();

    for (final prayerTime in _todaysPrayerTimes.values) {
      final difference = now.difference(prayerTime).abs();
      if (difference <= tolerance) {
        return true;
      }
    }

    return false;
  }

  // Get halal status for venue/deal
  HalalStatus getHalalStatus(Map<String, dynamic> item) {
    final isHalalCertified = item['isHalalCertified'] == true;
    final isHalalFriendly = item['isHalalFriendly'] == true;
    final hasAlcohol = item['hasAlcohol'] == true;
    final hasPork = item['hasPork'] == true;

    if (isHalalCertified) {
      return HalalStatus.certified;
    } else if (isHalalFriendly && !hasAlcohol && !hasPork) {
      return HalalStatus.friendly;
    } else if (hasAlcohol || hasPork) {
      return HalalStatus.notHalal;
    } else {
      return HalalStatus.unknown;
    }
  }

  // Filter halal venues/deals
  List<T> filterHalal<T>(List<T> items, bool onlyHalal) {
    if (!onlyHalal) return items;

    return items.where((item) {
      if (item is Map<String, dynamic>) {
        final status = getHalalStatus(item);
        return status == HalalStatus.certified ||
            status == HalalStatus.friendly;
      }
      return true;
    }).toList();
  }

  // Get Ramadan schedule info
  RamadanSchedule? getRamadanSchedule() {
    if (!_isRamadanMode) return null;

    final prayers = _todaysPrayerTimes;
    final fajr = prayers['Fajr'];
    final maghrib = prayers['Maghrib'];

    if (fajr == null || maghrib == null) return null;

    // Suhoor typically ends 10-15 minutes before Fajr
    final suhoorEnd = fajr.subtract(const Duration(minutes: 10));

    return RamadanSchedule(
      suhoorEnd: suhoorEnd,
      iftarStart: maghrib,
      fajrTime: fajr,
      maghribTime: maghrib,
    );
  }

  // Check if venue should be closed for prayer
  bool shouldVenueClosePrayer(Map<String, dynamic> venue) {
    final closesForPrayer = venue['closesForPrayer'] == true;
    return closesForPrayer && isPrayerTime();
  }

  // Get cultural holidays
  List<CulturalHoliday> getCulturalHolidays({int? year}) {
    final targetYear = year ?? DateTime.now().year;

    return [
      // Islamic holidays (approximate dates)
      CulturalHoliday(
        name: 'Eid al-Fitr',
        date: DateTime(targetYear, 4, 21), // Approximate
        type: HolidayType.religious,
        description: 'Festival of Breaking the Fast',
        isPublicHoliday: true,
      ),
      CulturalHoliday(
        name: 'Eid al-Adha',
        date: DateTime(targetYear, 6, 28), // Approximate
        type: HolidayType.religious,
        description: 'Festival of Sacrifice',
        isPublicHoliday: true,
      ),
      CulturalHoliday(
        name: 'Mawlid an-Nabi',
        date: DateTime(targetYear, 9, 15), // Approximate
        type: HolidayType.religious,
        description: 'Prophet Muhammad\'s Birthday',
        isPublicHoliday: true,
      ),
      // National holidays
      CulturalHoliday(
        name: 'Independence Day',
        date: DateTime(targetYear, 1, 11),
        type: HolidayType.national,
        description: 'Independence Manifesto Day',
        isPublicHoliday: true,
      ),
      CulturalHoliday(
        name: 'Throne Day',
        date: DateTime(targetYear, 7, 30),
        type: HolidayType.national,
        description: 'King Mohammed VI\'s Accession',
        isPublicHoliday: true,
      ),
      CulturalHoliday(
        name: 'Green March Day',
        date: DateTime(targetYear, 11, 6),
        type: HolidayType.national,
        description: 'Western Sahara March Anniversary',
        isPublicHoliday: true,
      ),
    ];
  }

  // Get localized text
  String getLocalizedText(Map<String, String> translations) {
    final languageCode = _currentLocale.languageCode;
    return translations[languageCode] ??
        translations['en'] ??
        translations.values.first;
  }

  // Get RTL text direction
  TextDirection getTextDirection() {
    return isArabicLocale ? TextDirection.rtl : TextDirection.ltr;
  }

  // Private helper methods
  Future<void> _loadUserPreferences() async {
    // In real app, load from SharedPreferences
    await Future.delayed(const Duration(milliseconds: 200));

    // Load cached preferences
    final cityPref = AppPerformanceService().getCachedData<String>('user_city');
    final localePref = AppPerformanceService()
        .getCachedData<Map<String, String>>('user_locale');

    if (cityPref != null) _currentCity = cityPref;
    if (localePref != null) {
      _currentLocale = Locale(localePref['language']!, localePref['country']);
    }
  }

  Future<void> _initializePrayerTimes() async {
    await _updatePrayerTimes();
  }

  Future<void> _updatePrayerTimes() async {
    await PerformanceUtils.simulateNetworkDelay();

    final today = DateTime.now();
    _todaysPrayerTimes = PrayerCalculator.generatePrayerTimes(today, _currentCity);

    // Cache for performance
    final cacheKey = '${_currentCity}_${today.toIso8601String().split('T')[0]}';
    _prayerTimesCache[cacheKey] = _todaysPrayerTimes;

    AppPerformanceService()
        .cacheData('prayer_times_$cacheKey', _todaysPrayerTimes);
  }

  Future<void> _checkRamadanStatus() async {
    // In real app, check against Islamic calendar
    final now = DateTime.now();

    // Mock Ramadan dates (approximate)
    final ramadanStart = DateTime(now.year, 3, 10);
    final ramadanEnd = DateTime(now.year, 4, 9);

    _isRamadanMode = now.isAfter(ramadanStart) && now.isBefore(ramadanEnd);
  }

  void _setupPrayerNotifications() {
    _prayerNotificationTimer?.cancel();

    // Check every minute for prayer time notifications
    _prayerNotificationTimer =
        Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkPrayerNotifications();
    });
  }

  void _checkPrayerNotifications() {
    // In real app, trigger local notifications for prayer times
    if (isPrayerTime(tolerance: const Duration(minutes: 1))) {
      debugPrint('Prayer time notification triggered');
    }
  }

  Future<void> _saveCityPreference(String city) async {
    await Future.delayed(const Duration(milliseconds: 100));
    AppPerformanceService().cacheData('user_city', city);
  }

  Future<void> _saveLocalePreference(Locale locale) async {
    await Future.delayed(const Duration(milliseconds: 100));
    AppPerformanceService().cacheData('user_locale', {
      'language': locale.languageCode,
      'country': locale.countryCode ?? '',
    });
  }

  @override
  void dispose() {
    _prayerNotificationTimer?.cancel();
    super.dispose();
  }
}