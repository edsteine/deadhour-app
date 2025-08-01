import 'package:deadhour/screens/utils/offline_service.dart';
import 'package:deadhour/screens/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// Offline Status Widget for DeadHour App
// Shows connectivity status and sync progress to users
class OfflineStatusWidget extends ConsumerWidget {
  final bool showFullStatus;
  final bool showPendingActions;

  const OfflineStatusWidget({
    super.key,
    this.showFullStatus = true,
    this.showPendingActions = true,
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

        return _buildStatusWidget(context, offlineService);
      },
    );
  }

  Widget _buildStatusWidget(
      BuildContext context, OfflineService offlineService) {
    if (offlineService.isOnline && offlineService.pendingActionsCount == 0) {
      // Online with no pending actions - minimal or hidden status
      return showFullStatus ? _buildOnlineStatus() : const SizedBox.shrink();
    }

    if (!offlineService.isOnline) {
      // Offline mode
      return _buildOfflineStatus(offlineService);
    }

    if (offlineService.pendingActionsCount > 0) {
      // Online but with pending actions
      return _buildSyncingStatus(offlineService);
    }

    return const SizedBox.shrink();
  }

  Widget _buildOnlineStatus() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.cloud_done,
            size: 16,
            color: Colors.green.shade600,
          ),
          const SizedBox(width: 6),
          Text(
            'Online',
            style: TextStyle(
              fontSize: 12,
              color: Colors.green.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfflineStatus(OfflineService offlineService) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        children: [
          Icon(
            Icons.cloud_off,
            size: 20,
            color: Colors.orange.shade600,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Offline Mode',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange.shade700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'You can continue browsing with cached data',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.orange.shade600,
                  ),
                ),
                if (showPendingActions &&
                    offlineService.pendingActionsCount > 0) ...[
                  const SizedBox(height: 4),
                  Text(
                    '${offlineService.pendingActionsCount} actions pending sync',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.orange.shade500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSyncingStatus(OfflineService offlineService) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.moroccoGreen.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(AppTheme.moroccoGreen),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Syncing ${offlineService.pendingActionsCount} actions...',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryText,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Your actions are being saved to the server',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

