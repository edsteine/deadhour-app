import 'package:flutter/material.dart';
import 'package:deadhour/services/offline_service.dart';
import 'package:deadhour/utils/theme.dart';
import 'package:deadhour/widgets/common/dead_hour_app_bar.dart';

class OfflineSettingsScreen extends StatefulWidget {
  const OfflineSettingsScreen({super.key});

  @override
  State<OfflineSettingsScreen> createState() => _OfflineSettingsScreenState();
}

class _OfflineSettingsScreenState extends State<OfflineSettingsScreen> {
  final _offlineService = OfflineService();

  @override
  void initState() {
    super.initState();
    _offlineService.addListener(_onOfflineServiceChanged);
  }

  @override
  void dispose() {
    _offlineService.removeListener(_onOfflineServiceChanged);
    super.dispose();
  }

  void _onOfflineServiceChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DeadHourAppBar(
        title: 'Offline Settings',
        showBackButton: true,
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: ListView(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          children: [
            _buildConnectionStatus(),
            const SizedBox(height: AppTheme.spacing24),
            _buildSyncSection(),
            const SizedBox(height: AppTheme.spacing24),
            _buildCacheSection(),
            const SizedBox(height: AppTheme.spacing24),
            _buildDataManagementSection(),
            const SizedBox(height: AppTheme.spacing24),
            _buildOfflineCapabilitiesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectionStatus() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _offlineService.isOnline ? Icons.wifi : Icons.wifi_off,
                  color: _offlineService.isOnline ? Colors.green : Colors.red,
                  size: 24,
                ),
                const SizedBox(width: AppTheme.spacing12),
                Text(
                  'Connection Status',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            // Connection indicator
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacing12,
                vertical: AppTheme.spacing8,
              ),
              decoration: BoxDecoration(
                color: _offlineService.isOnline
                    ? Colors.green.withValues(alpha: 0.1)
                    : Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                border: Border.all(
                  color: _offlineService.isOnline ? Colors.green : Colors.red,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _offlineService.isOnline ? Icons.check_circle : Icons.error,
                    color: _offlineService.isOnline ? Colors.green : Colors.red,
                    size: 16,
                  ),
                  const SizedBox(width: AppTheme.spacing8),
                  Text(
                    _offlineService.isOnline ? 'Online' : 'Offline',
                    style: TextStyle(
                      color: _offlineService.isOnline ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: AppTheme.spacing16),
            
            // Connection types
            if (_offlineService.connectionTypes.isNotEmpty)
              Wrap(
                spacing: AppTheme.spacing8,
                children: _offlineService.connectionTypes.map((type) {
                  return Chip(
                    label: Text(_getConnectionTypeText(type)),
                    avatar: Icon(_getConnectionTypeIcon(type), size: 16),
                    backgroundColor: AppTheme.surfaceColor,
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSyncSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.sync,
                  color: AppTheme.moroccoGreen,
                  size: 24,
                ),
                const SizedBox(width: AppTheme.spacing12),
                Text(
                  'Synchronization',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            // Last sync time
            if (_offlineService.lastSyncTime != null)
              ListTile(
                leading: const Icon(Icons.schedule),
                title: const Text('Last Sync'),
                subtitle: Text(
                  _formatDateTime(_offlineService.lastSyncTime!),
                ),
                contentPadding: EdgeInsets.zero,
              ),
            
            // Pending actions
            ListTile(
              leading: Icon(
                Icons.pending_actions,
                color: _offlineService.pendingActionsCount > 0
                    ? Colors.orange
                    : Colors.grey,
              ),
              title: const Text('Pending Actions'),
              subtitle: Text(
                '${_offlineService.pendingActionsCount} actions waiting to sync',
              ),
              trailing: _offlineService.pendingActionsCount > 0
                  ? Chip(
                      label: Text(_offlineService.pendingActionsCount.toString()),
                      backgroundColor: Colors.orange.withValues(alpha: 0.2),
                    )
                  : null,
              contentPadding: EdgeInsets.zero,
            ),
            
            const SizedBox(height: AppTheme.spacing16),
            
            // Sync actions
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _offlineService.isOnline && !_offlineService.isSyncInProgress
                        ? _handleForceSync
                        : null,
                    icon: _offlineService.isSyncInProgress
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.refresh),
                    label: Text(
                      _offlineService.isSyncInProgress ? 'Syncing...' : 'Force Sync',
                    ),
                  ),
                ),
                const SizedBox(width: AppTheme.spacing12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _offlineService.isOnline && 
                               _offlineService.pendingActionsCount > 0 && 
                               !_offlineService.isSyncInProgress
                        ? _handleSyncPending
                        : null,
                    icon: const Icon(Icons.upload),
                    label: const Text('Sync Pending'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCacheSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.storage,
                  color: AppTheme.moroccoGreen,
                  size: 24,
                ),
                const SizedBox(width: AppTheme.spacing12),
                Text(
                  'Cache Management',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            // Cache size
            ListTile(
              leading: const Icon(Icons.folder_open),
              title: const Text('Cache Size'),
              subtitle: Text(_formatBytes(_offlineService.getOfflineDataSize())),
              contentPadding: EdgeInsets.zero,
            ),
            
            // Cached data types
            _buildCacheDataType('Venues', Icons.place, _offlineService.hasOfflineData('venues')),
            _buildCacheDataType('Deals', Icons.local_offer, _offlineService.hasOfflineData('deals')),
            _buildCacheDataType('Favorites', Icons.favorite, _offlineService.hasOfflineData('user_favorites')),
            _buildCacheDataType('Search History', Icons.history, _offlineService.hasOfflineData('search_history')),
            
            const SizedBox(height: AppTheme.spacing16),
            
            // Cache actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _handleClearCache,
                    icon: const Icon(Icons.delete_sweep),
                    label: const Text('Clear Cache'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCacheDataType(String title, IconData icon, bool isAvailable) {
    return ListTile(
      leading: Icon(
        icon,
        color: isAvailable ? AppTheme.moroccoGreen : Colors.grey,
      ),
      title: Text(title),
      trailing: Icon(
        isAvailable ? Icons.check_circle : Icons.radio_button_unchecked,
        color: isAvailable ? AppTheme.moroccoGreen : Colors.grey,
        size: 20,
      ),
      contentPadding: const EdgeInsets.only(left: AppTheme.spacing24),
      dense: true,
    );
  }

  Widget _buildDataManagementSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.download,
                  color: AppTheme.moroccoGreen,
                  size: 24,
                ),
                const SizedBox(width: AppTheme.spacing12),
                Text(
                  'Data Management',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            // Download for offline use
            ListTile(
              leading: const Icon(Icons.download_for_offline),
              title: const Text('Download Current Data'),
              subtitle: const Text('Cache current venues and deals for offline use'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: _offlineService.isOnline ? _handleDownloadForOffline : null,
              contentPadding: EdgeInsets.zero,
            ),
            
            // Auto-sync settings
            ListTile(
              leading: const Icon(Icons.sync_alt),
              title: const Text('Auto Sync Settings'),
              subtitle: const Text('Configure automatic synchronization'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: _showAutoSyncSettings,
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOfflineCapabilitiesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.offline_bolt,
                  color: AppTheme.moroccoGreen,
                  size: 24,
                ),
                const SizedBox(width: AppTheme.spacing12),
                Text(
                  'Offline Capabilities',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            _buildCapabilityItem(
              'Browse Venues',
              'View cached venue information',
              Icons.place,
              _offlineService.hasOfflineData('venues'),
            ),
            _buildCapabilityItem(
              'View Deals',
              'Access saved deals and offers',
              Icons.local_offer,
              _offlineService.hasOfflineData('deals'),
            ),
            _buildCapabilityItem(
              'Manage Favorites',
              'Add/remove favorites (syncs when online)',
              Icons.favorite,
              true,
            ),
            _buildCapabilityItem(
              'Search History',
              'Access previous searches',
              Icons.history,
              _offlineService.hasOfflineData('search_history'),
            ),
            _buildCapabilityItem(
              'Queue Actions',
              'Actions performed offline will sync automatically',
              Icons.queue,
              true,
            ),
            
            const SizedBox(height: AppTheme.spacing16),
            
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing12),
              decoration: BoxDecoration(
                color: AppTheme.moroccoGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Offline Tips',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: AppTheme.spacing8),
                  Text(
                    '• Download data before traveling to areas with poor connectivity\n'
                    '• Actions performed offline will automatically sync when connection is restored\n'
                    '• Use WiFi when available to reduce mobile data usage\n'
                    '• Clear cache periodically to free up storage space',
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCapabilityItem(String title, String subtitle, IconData icon, bool isAvailable) {
    return ListTile(
      leading: Icon(
        icon,
        color: isAvailable ? AppTheme.moroccoGreen : Colors.grey,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(
        isAvailable ? Icons.check_circle : Icons.help_outline,
        color: isAvailable ? AppTheme.moroccoGreen : Colors.orange,
        size: 20,
      ),
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }

  Future<void> _handleRefresh() async {
    if (!_offlineService.isOnline) return;
    
    try {
      await _offlineService.forceRefresh();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data refreshed successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Refresh failed: $e')),
        );
      }
    }
  }

  Future<void> _handleForceSync() async {
    await _offlineService.forceRefresh();
  }

  Future<void> _handleSyncPending() async {
    await _offlineService.syncPendingActions();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pending actions synced')),
      );
    }
  }

  Future<void> _handleClearCache() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text(
          'This will remove all offline data. You\'ll need to download it again when online. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
    
    if (confirmed == true) {
      await _offlineService.clearOfflineData();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cache cleared successfully')),
        );
      }
    }
  }

  Future<void> _handleDownloadForOffline() async {
    try {
      await _offlineService.forceRefresh();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data downloaded for offline use')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Download failed: $e')),
        );
      }
    }
  }

  void _showAutoSyncSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Auto Sync Settings'),
        content: const Text('Auto sync configuration coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
  }

  String _getConnectionTypeText(dynamic type) {
    switch (type.toString()) {
      case 'ConnectivityResult.wifi':
        return 'WiFi';
      case 'ConnectivityResult.mobile':
        return 'Mobile';
      case 'ConnectivityResult.ethernet':
        return 'Ethernet';
      case 'ConnectivityResult.bluetooth':
        return 'Bluetooth';
      default:
        return 'Unknown';
    }
  }

  IconData _getConnectionTypeIcon(dynamic type) {
    switch (type.toString()) {
      case 'ConnectivityResult.wifi':
        return Icons.wifi;
      case 'ConnectivityResult.mobile':
        return Icons.signal_cellular_4_bar;
      case 'ConnectivityResult.ethernet':
        return Icons.cable;
      case 'ConnectivityResult.bluetooth':
        return Icons.bluetooth;
      default:
        return Icons.device_unknown;
    }
  }
}