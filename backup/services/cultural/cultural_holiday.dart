// Holiday types
enum HolidayType {
  religious,
  national,
  cultural,
}

// Cultural holiday information
class CulturalHoliday {
  final String name;
  final DateTime date;
  final HolidayType type;
  final String description;
  final bool isPublicHoliday;

  const CulturalHoliday({
    required this.name,
    required this.date,
    required this.type,
    required this.description,
    required this.isPublicHoliday,
  });
}