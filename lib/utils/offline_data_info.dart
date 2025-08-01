import 'package:deadhour/utils/offline_data_status.dart';

/// Offline data info
class OfflineDataInfo {
  final OfflineDataStatus status;
  final DateTime? lastUpdated;
  final int size;
  final bool isSyncing;

  const OfflineDataInfo({
    required this.status,
    this.lastUpdated,
    required this.size,
    required this.isSyncing,
  });
}