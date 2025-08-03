// Ramadan schedule information
class RamadanSchedule {
  final DateTime suhoorEnd;
  final DateTime iftarStart;
  final DateTime fajrTime;
  final DateTime maghribTime;

  const RamadanSchedule({
    required this.suhoorEnd,
    required this.iftarStart,
    required this.fajrTime,
    required this.maghribTime,
  });
}