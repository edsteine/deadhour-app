// Prayer time calculation utilities
class PrayerCalculator {
  static Map<String, DateTime> generatePrayerTimes(DateTime date, String city) {
    // Mock prayer times calculation (in real app, use precise calculation library)
    final baseTime = DateTime(date.year, date.month, date.day);

    // Approximate prayer times for Morocco (vary by season and location)
    switch (city.toLowerCase()) {
      case 'casablanca':
        return {
          'Fajr': baseTime.add(const Duration(hours: 5, minutes: 30)),
          'Dhuhr': baseTime.add(const Duration(hours: 13, minutes: 15)),
          'Asr': baseTime.add(const Duration(hours: 16, minutes: 30)),
          'Maghrib': baseTime.add(const Duration(hours: 19, minutes: 45)),
          'Isha': baseTime.add(const Duration(hours: 21, minutes: 15)),
        };
      case 'marrakech':
        return {
          'Fajr': baseTime.add(const Duration(hours: 5, minutes: 35)),
          'Dhuhr': baseTime.add(const Duration(hours: 13, minutes: 20)),
          'Asr': baseTime.add(const Duration(hours: 16, minutes: 35)),
          'Maghrib': baseTime.add(const Duration(hours: 19, minutes: 50)),
          'Isha': baseTime.add(const Duration(hours: 21, minutes: 20)),
        };
      case 'rabat':
        return {
          'Fajr': baseTime.add(const Duration(hours: 5, minutes: 25)),
          'Dhuhr': baseTime.add(const Duration(hours: 13, minutes: 10)),
          'Asr': baseTime.add(const Duration(hours: 16, minutes: 25)),
          'Maghrib': baseTime.add(const Duration(hours: 19, minutes: 40)),
          'Isha': baseTime.add(const Duration(hours: 21, minutes: 10)),
        };
      default:
        return {
          'Fajr': baseTime.add(const Duration(hours: 5, minutes: 30)),
          'Dhuhr': baseTime.add(const Duration(hours: 13, minutes: 15)),
          'Asr': baseTime.add(const Duration(hours: 16, minutes: 30)),
          'Maghrib': baseTime.add(const Duration(hours: 19, minutes: 45)),
          'Isha': baseTime.add(const Duration(hours: 21, minutes: 15)),
        };
    }
  }
}