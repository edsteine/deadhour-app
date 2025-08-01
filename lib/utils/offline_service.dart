import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:deadhour/utils/performance_utils.dart';
import 'package:deadhour/utils/app_performance_service.dart';

// Offline Service for DeadHour App
// Handles data persistence and offline functionality for Morocco's mobile infrastructure
class OfflineService extends ChangeNotifier {
  static final OfflineService _instance = OfflineService._internal();
  factory OfflineService() => _instance;
  OfflineService._internal();

  bool _isInitialized = false;
  bool _isOnline = true;
  bool _syncInProgress = false;
  DateTime? _lastSyncTime;
  List<ConnectivityResult> _connectionTypes = [ConnectivityResult.none];

  // Data storage
  final Map<String, dynamic> _localData = {};
  final Map<String, DateTime> _dataTimestamps = {};
  final List<Map<String, dynamic>> _pendingActions = [];

  // Cache configuration
  static const Duration _cacheExpiry = Duration(hours: 24);
  static const Duration _syncInterval = Duration(minutes: 30);

  // Getters
  bool get isInitialized => _isInitialized;
  bool get isOnline => _isOnline;
  bool get isSyncInProgress => _syncInProgress;
  DateTime? get lastSyncTime => _lastSyncTime;
  List<ConnectivityResult> get connectionTypes => _connectionTypes;
  int get pendingActionsCount => _pendingActions.length;

  // Initialize offline service
  Future<void> initialize() async {
    try {
      // Initialize connectivity monitoring
      await _initializeConnectivity();

      // Load cached data from local storage
      await _loadCachedData();

      // Setup periodic sync
      _setupPeriodicSync();

      _isInitialized = true;
      notifyListeners();

      debugPrint('OfflineService initialized successfully');
    } catch (error) {
      debugPrint('OfflineService initialization error: $error');
    }
  }

  // Check if data is available offline
  bool hasOfflineData(String key) {
    if (!_localData.containsKey(key)) return false;

    final timestamp = _dataTimestamps[key];
    if (timestamp == null) return false;

    return DateTime.now().difference(timestamp) < _cacheExpiry;
  }

  // Store data for offline access
  Future<void> storeOfflineData(String key, dynamic data) async {
    try {
      _localData[key] = data;
      _dataTimestamps[key] = DateTime.now();

      // Persist to local storage
      await _persistData(key, data);

      // Cache with performance service
      AppPerformanceService().cacheData('offline_$key', data);

      notifyListeners();
    } catch (error) {
      debugPrint('Failed to store offline data: $error');
    }
  }

  // Retrieve offline data
  T? getOfflineData<T>(String key) {
    if (!hasOfflineData(key)) return null;
    return _localData[key] as T?;
  }

  // Queue action for when connection is restored
  Future<void> queueOfflineAction(
      String type, Map<String, dynamic> data) async {
    try {
      final action = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'type': type,
        'data': data,
        'timestamp': DateTime.now().toIso8601String(),
        'retries': 0,
      };

      _pendingActions.add(action);
      await _persistPendingActions();

      notifyListeners();

      // Try to sync immediately if online
      if (_isOnline) {
        _syncPendingActions();
      }
    } catch (error) {
      debugPrint('Failed to queue offline action: $error');
    }
  }

  // Sync all pending actions
  Future<void> syncPendingActions() async {
    if (!_isOnline || _syncInProgress) return;

    await _syncPendingActions();
  }

  // Force refresh data from server
  Future<void> forceRefresh() async {
    if (!_isOnline) {
      throw Exception('Cannot refresh data while offline');
    }

    try {
      _syncInProgress = true;
      notifyListeners();

      // Refresh critical data
      await _refreshDeals();
      await _refreshVenues();
      await _refreshUserData();

      _lastSyncTime = DateTime.now();
      await _persistLastSyncTime();
    } catch (error) {
      debugPrint('Force refresh failed: $error');
      rethrow;
    } finally {
      _syncInProgress = false;
      notifyListeners();
    }
  }

  // Get offline deals
  List<Deal> getOfflineDeals({String? category}) {
    final dealsData = getOfflineData<List<dynamic>>('deals') ?? [];

    final deals = dealsData.map((data) => Deal.fromJson(data)).toList();

    if (category != null) {
      return deals.where((deal) => deal.categories.contains(category)).toList();
    }

    return deals;
  }

  // Get offline venues
  List<Venue> getOfflineVenues({String? city}) {
    final venuesData = getOfflineData<List<dynamic>>('venues') ?? [];

    final venues = venuesData.map((data) => Venue.fromJson(data)).toList();

    if (city != null) {
      return venues.where((venue) => venue.city == city).toList();
    }

    return venues;
  }

  // Store user favorites offline
  Future<void> storeUserFavorites(List<String> favoriteIds) async {
    await storeOfflineData('user_favorites', favoriteIds);
  }

  // Get user favorites offline
  List<String> getUserFavorites() {
    return getOfflineData<List<dynamic>>('user_favorites')?.cast<String>() ??
        [];
  }

  // Store search history offline
  Future<void> storeSearchHistory(List<String> searches) async {
    await storeOfflineData('search_history', searches.take(20).toList());
  }

  // Get search history offline
  List<String> getSearchHistory() {
    return getOfflineData<List<dynamic>>('search_history')?.cast<String>() ??
        [];
  }

  // Check data freshness
  bool isDataFresh(String key, {Duration? maxAge}) {
    final timestamp = _dataTimestamps[key];
    if (timestamp == null) return false;

    final age = maxAge ?? _cacheExpiry;
    return DateTime.now().difference(timestamp) < age;
  }

  // Clear all offline data
  Future<void> clearOfflineData() async {
    try {
      _localData.clear();
      _dataTimestamps.clear();
      _pendingActions.clear();

      await _clearPersistedData();
      notifyListeners();
    } catch (error) {
      debugPrint('Failed to clear offline data: $error');
    }
  }

  // Get offline data size
  int getOfflineDataSize() {
    int totalSize = 0;
    for (final data in _localData.values) {
      if (data is String) {
        totalSize += data.length;
      } else if (data is List || data is Map) {
        totalSize += jsonEncode(data).length;
      }
    }
    return totalSize;
  }

  // Private helper methods
  Future<void> _initializeConnectivity() async {
    try {
      // Check initial connectivity
      _connectionTypes = await Connectivity().checkConnectivity();
      _isOnline =
          _connectionTypes.any((type) => type != ConnectivityResult.none);

      // Listen for connectivity changes
      Connectivity()
          .onConnectivityChanged
          .listen((List<ConnectivityResult> results) {
        _onConnectivityChanged(results);
      });
    } catch (error) {
      debugPrint('Connectivity initialization failed: $error');
      _isOnline = false;
    }
  }

  void _onConnectivityChanged(List<ConnectivityResult> results) {
    final wasOnline = _isOnline;
    _connectionTypes = results;
    _isOnline = results.any((type) => type != ConnectivityResult.none);

    if (!wasOnline && _isOnline) {
      // Connection restored
      debugPrint('Connection restored, starting sync...');
      _syncPendingActions();
    } else if (wasOnline && !_isOnline) {
      // Connection lost
      debugPrint('Connection lost, switching to offline mode');
    }

    notifyListeners();
  }

  Future<void> _loadCachedData() async {
    try {
      // In real app, load from SharedPreferences or SQLite
      await Future.delayed(const Duration(milliseconds: 500));

      // Load last sync time
      await _loadLastSyncTime();

      // Load pending actions
      await _loadPendingActions();

      debugPrint('Cached data loaded successfully');
    } catch (error) {
      debugPrint('Failed to load cached data: $error');
    }
  }

  void _setupPeriodicSync() {
    Timer.periodic(_syncInterval, (timer) {
      if (_isOnline && !_syncInProgress) {
        _syncPendingActions();
      }
    });
  }

  Future<void> _syncPendingActions() async {
    if (_pendingActions.isEmpty) return;

    try {
      _syncInProgress = true;
      notifyListeners();

      final actionsToRemove = <Map<String, dynamic>>[];

      for (final action in _pendingActions) {
        try {
          await _executeAction(action);
          actionsToRemove.add(action);
        } catch (error) {
          // Increment retry count
          action['retries'] = (action['retries'] ?? 0) + 1;

          // Remove after max retries
          if (action['retries'] >= 3) {
            actionsToRemove.add(action);
            debugPrint(
                'Action ${action['id']} failed after 3 retries, removing');
          }
        }
      }

      // Remove successfully synced actions
      for (final action in actionsToRemove) {
        _pendingActions.remove(action);
      }

      if (actionsToRemove.isNotEmpty) {
        await _persistPendingActions();
      }

      _lastSyncTime = DateTime.now();
      await _persistLastSyncTime();
    } catch (error) {
      debugPrint('Sync failed: $error');
    } finally {
      _syncInProgress = false;
      notifyListeners();
    }
  }

  Future<void> _executeAction(Map<String, dynamic> action) async {
    final type = action['type'] as String;
    final data = action['data'] as Map<String, dynamic>;

    await PerformanceUtils.simulateNetworkDelay();

    switch (type) {
      case 'book_deal':
        // Simulate deal booking API call
        await Future.delayed(const Duration(milliseconds: 800));
        debugPrint('Deal booking synced: ${data['dealId']}');
        break;

      case 'save_favorite':
        // Simulate favorite save API call
        await Future.delayed(const Duration(milliseconds: 500));
        debugPrint('Favorite synced: ${data['itemId']}');
        break;

      case 'post_message':
        // Simulate message posting API call
        await Future.delayed(const Duration(milliseconds: 600));
        debugPrint('Message synced: ${data['messageId']}');
        break;

      case 'update_profile':
        // Simulate profile update API call
        await Future.delayed(const Duration(milliseconds: 700));
        debugPrint('Profile update synced');
        break;

      default:
        debugPrint('Unknown action type: $type');
    }
  }

  Future<void> _refreshDeals() async {
    // Simulate API call to refresh deals
    await PerformanceUtils.simulateNetworkDelay();
    await Future.delayed(const Duration(milliseconds: 1000));

    // Mock deals data
    final mockDeals = [
      {
        'id': 'deal_1',
        'title': 'Café Atlas - 40% Off',
        'category': 'food',
        'discount': 40,
        'validUntil':
            DateTime.now().add(const Duration(hours: 6)).toIso8601String(),
      },
      {
        'id': 'deal_2',
        'title': 'Wellness Spa - 30% Off',
        'category': 'wellness',
        'discount': 30,
        'validUntil':
            DateTime.now().add(const Duration(hours: 4)).toIso8601String(),
      },
    ];

    await storeOfflineData('deals', mockDeals);
  }

  Future<void> _refreshVenues() async {
    // Simulate API call to refresh venues
    await PerformanceUtils.simulateNetworkDelay();
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock venues data
    final mockVenues = [
      {
        'id': 'venue_1',
        'name': 'Café Atlas',
        'city': 'Marrakech',
        'category': 'food',
        'rating': 4.8,
      },
      {
        'id': 'venue_2',
        'name': 'Royal Spa',
        'city': 'Casablanca',
        'category': 'wellness',
        'rating': 4.6,
      },
    ];

    await storeOfflineData('venues', mockVenues);
  }

  Future<void> _refreshUserData() async {
    // Simulate API call to refresh user data
    await PerformanceUtils.simulateNetworkDelay();
    await Future.delayed(const Duration(milliseconds: 600));

    // Mock user preferences
    await storeOfflineData('user_preferences', {
      'language': 'en',
      'city': 'Casablanca',
      'categories': ['food', 'entertainment'],
    });
  }

  Future<void> _persistData(String key, dynamic data) async {
    // In real app, save to SharedPreferences or SQLite
    await Future.delayed(const Duration(milliseconds: 100));
  }

  Future<void> _persistPendingActions() async {
    // In real app, save pending actions to local storage
    await Future.delayed(const Duration(milliseconds: 100));
  }

  Future<void> _loadPendingActions() async {
    // In real app, load pending actions from local storage
    await Future.delayed(const Duration(milliseconds: 100));
  }

  Future<void> _persistLastSyncTime() async {
    // In real app, save last sync time to SharedPreferences
    await Future.delayed(const Duration(milliseconds: 50));
  }

  Future<void> _loadLastSyncTime() async {
    // In real app, load last sync time from SharedPreferences
    await Future.delayed(const Duration(milliseconds: 50));
    // _lastSyncTime = loadedTime;
  }

  Future<void> _clearPersistedData() async {
    // In real app, clear all persisted data
    await Future.delayed(const Duration(milliseconds: 200));
  }
}