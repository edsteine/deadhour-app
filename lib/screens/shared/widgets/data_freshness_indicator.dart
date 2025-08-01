import 'package:deadhour/screens/utils/offline_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Data freshness indicator
class DataFreshnessIndicator extends ConsumerWidget {
  final String dataKey;
  final String label;

  const DataFreshnessIndicator({
    super.key,
    required this.dataKey,
    required this.label,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListenableBuilder(
      listenable: OfflineService(),
      builder: (context, child) {
        final offlineService = OfflineService();

        if (!offlineService.isInitialized) {
          return const SizedBox.shrink();
        }

        final hasFreshData = offlineService.isDataFresh(dataKey);
        final hasOfflineData = offlineService.hasOfflineData(dataKey);

        if (!hasOfflineData) {
          return const SizedBox.shrink();
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: hasFreshData ? Colors.green.shade50 : Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color:
                  hasFreshData ? Colors.green.shade200 : Colors.orange.shade200,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                hasFreshData ? Icons.check_circle : Icons.access_time,
                size: 12,
                color: hasFreshData
                    ? Colors.green.shade600
                    : Colors.orange.shade600,
              ),
              const SizedBox(width: 4),
              Text(
                hasFreshData ? '$label (fresh)' : '$label (cached)',
                style: TextStyle(
                  fontSize: 10,
                  color: hasFreshData
                      ? Colors.green.shade700
                      : Colors.orange.shade700,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}