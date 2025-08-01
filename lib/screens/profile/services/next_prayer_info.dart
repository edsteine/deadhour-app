// Next prayer information
class NextPrayerInfo {
  final String name;
  final DateTime time;
  final Duration timeUntil;
  final bool isNext;

  const NextPrayerInfo({
    required this.name,
    required this.time,
    required this.timeUntil,
    required this.isNext,
  });
}