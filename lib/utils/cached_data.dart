/// Cached data with TTL
class CachedData {
  final Map<String, dynamic> data;
  final DateTime expiryTime;

  CachedData(this.data, this.expiryTime);

  bool get isExpired => DateTime.now().isAfter(expiryTime);
}