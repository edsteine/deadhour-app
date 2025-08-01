import '../../utils/offline_service.dart';
import '../../utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Floating action button for manual sync
class SyncFloatingActionButton extends ConsumerWidget {
  const SyncFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListenableBuilder(
      listenable: OfflineService(),
      builder: (context, child) {
        final offlineService = OfflineService();

        if (!offlineService.isInitialized ||
            !offlineService.isOnline ||
            offlineService.pendingActionsCount == 0) {
          return const SizedBox.shrink();
        }

        return FloatingActionButton.small(
          heroTag: "sync_fab",
          onPressed: offlineService.isSyncInProgress
              ? null
              : () => _handleManualSync(context, offlineService),
          backgroundColor: AppTheme.moroccoGreen,
          foregroundColor: Colors.white,
          child: offlineService.isSyncInProgress
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                )
              : const Icon(Icons.sync, size: 18),
        );
      },
    );
  }

  Future<void> _handleManualSync(
      BuildContext context, OfflineService offlineService) async {
    try {
      await offlineService.syncPendingActions();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Synced ${offlineService.pendingActionsCount} actions'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sync failed: ${error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}