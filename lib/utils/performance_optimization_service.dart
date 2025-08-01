import 'dart:async';

import 'package:flutter/foundation.dart';

import 'cached_data.dart';
import 'lru_cache.dart';


/// Performance optimization service for DeadHour app
/// Handles memory management, lazy loading, caching, and performance monitoring
class PerformanceOptimizationService {
  static final PerformanceOptimizationService _instance = PerformanceOptimizationService._internal();
  factory PerformanceOptimizationService() => _instance;
  PerformanceOptimizationService._internal();

  // Image cache with LRU eviction
  final _imageCache = LRUCache<String, dynamic>(maxSize: 100);
  
  // Data cache with TTL
  final Map<String, CachedData> _dataCache = {};
  
  // Performance metrics
  final Map<String, List<int>> _performanceMetrics = {
    'screen_load_times': [],
    'search_response_times': [],
    'image_load_times': [],
    'api_response_times': [],
  };

  // Memory usage tracking
  int _currentMemoryUsage = 0;
  final int _maxMemoryUsage = 50 * 1024 * 1024; // 50MB limit
  
  // Lazy loading configurations
  final Map<String, bool> _lazyLoadingStates = {};
  
  // Performance optimization settings
  final Map<String, dynamic> _optimizationSettings = {
    'enable_image_caching': true,
    'enable_data_caching': true,
    'enable_lazy_loading': true,
    'enable_memory_optimization': true,
    'cache_ttl_minutes': 30,
    'max_concurrent_image_loads': 5,
    'preload_next_items': 3,
  };

  /// Initialize performance monitoring
  void initialize() {
    _startMemoryMonitoring();
    _startPerformanceMetricsCollection();
    _optimizeImageLoading();
  }

  /// Cache management for venue data
  void cacheVenueData(String venueId, Map<String, dynamic> data) {
    if (!_optimizationSettings['enable_data_caching']) return;
    
    final ttl = Duration(minutes: _optimizationSettings['cache_ttl_minutes']);
    _dataCache[venueId] = CachedData(data, DateTime.now().add(ttl));
    
    _cleanExpiredCache();
  }

  /// Retrieve cached venue data
  Map<String, dynamic>? getCachedVenueData(String venueId) {
    if (!_optimizationSettings['enable_data_caching']) return null;
    
    final cached = _dataCache[venueId];
    if (cached != null && !cached.isExpired) {
      return cached.data;
    }
    
    // Remove expired data
    if (cached != null && cached.isExpired) {
      _dataCache.remove(venueId);
    }
    
    return null;
  }

  /// Preload venue data for improved performance
  Future<void> preloadVenueData(List<String> venueIds) async {
    if (!_optimizationSettings['enable_data_caching']) return;
    
    // Limit concurrent preloads to avoid overwhelming the system
    const maxConcurrent = 3;
    final chunks = _chunkList(venueIds, maxConcurrent);
    
    for (final chunk in chunks) {
      await Future.wait(chunk.map((venueId) => _preloadSingleVenue(venueId)));
    }
  }

  /// Lazy loading state management
  void setLazyLoadingState(String key, bool isLoading) {
    _lazyLoadingStates[key] = isLoading;
  }

  bool isLazyLoading(String key) {
    return _lazyLoadingStates[key] ?? false;
  }

  /// Image optimization and caching
  void cacheImage(String imageUrl, dynamic imageData) {
    if (!_optimizationSettings['enable_image_caching']) return;
    
    _imageCache.put(imageUrl, imageData);
    _updateMemoryUsage();
  }

  dynamic getCachedImage(String imageUrl) {
    if (!_optimizationSettings['enable_image_caching']) return null;
    return _imageCache.get(imageUrl);
  }

  /// Memory optimization
  void optimizeMemoryUsage() {
    if (!_optimizationSettings['enable_memory_optimization']) return;
    
    if (_currentMemoryUsage > _maxMemoryUsage) {
      _performMemoryCleanup();
    }
  }

  /// Performance metrics collection
  void recordScreenLoadTime(String screenName, int milliseconds) {
    _performanceMetrics['screen_load_times']?.add(milliseconds);
    _keepMetricsWithinLimit('screen_load_times');
    
    if (kDebugMode) {
      print('Screen $screenName loaded in ${milliseconds}ms');
    }
  }

  void recordSearchResponseTime(int milliseconds) {
    _performanceMetrics['search_response_times']?.add(milliseconds);
    _keepMetricsWithinLimit('search_response_times');
  }

  void recordImageLoadTime(int milliseconds) {
    _performanceMetrics['image_load_times']?.add(milliseconds);
    _keepMetricsWithinLimit('image_load_times');
  }

  void recordApiResponseTime(String endpoint, int milliseconds) {
    _performanceMetrics['api_response_times']?.add(milliseconds);
    _keepMetricsWithinLimit('api_response_times');
  }

  /// Get performance analytics
  Map<String, dynamic> getPerformanceAnalytics() {
    final analytics = <String, dynamic>{};
    
    for (final entry in _performanceMetrics.entries) {
      final times = entry.value;
      if (times.isNotEmpty) {
        analytics[entry.key] = {
          'average': times.reduce((a, b) => a + b) / times.length,
          'min': times.reduce((a, b) => a < b ? a : b),
          'max': times.reduce((a, b) => a > b ? a : b),
          'count': times.length,
        };
      }
    }
    
    analytics['memory_usage'] = {
      'current_mb': (_currentMemoryUsage / (1024 * 1024)).toStringAsFixed(2),
      'max_mb': (_maxMemoryUsage / (1024 * 1024)).toStringAsFixed(2),
      'usage_percentage': ((_currentMemoryUsage / _maxMemoryUsage) * 100).toStringAsFixed(1),
    };
    
    analytics['cache_stats'] = {
      'image_cache_size': _imageCache.length,
      'data_cache_size': _dataCache.length,
      'image_cache_hit_rate': _imageCache.hitRate.toStringAsFixed(2),
    };
    
    return analytics;
  }

  /// Optimize app startup performance
  void optimizeAppStartup() {
    // Preload critical resources
    _preloadCriticalData();
    
    // Initialize services in background
    Timer(const Duration(milliseconds: 500), () {
      _initializeBackgroundServices();
    });
  }

  /// List virtualization helper for large lists
  bool shouldRenderItem(int index, int visibleStart, int visibleEnd, int bufferSize) {
    final start = (visibleStart - bufferSize).clamp(0, double.infinity).toInt();
    final end = visibleEnd + bufferSize;
    return index >= start && index <= end;
  }

  /// Batch processing for heavy operations
  Future<List<T>> processBatch<T>(
    List<dynamic> items,
    Future<T> Function(dynamic) processor, {
    int batchSize = 10,
    Duration batchDelay = const Duration(milliseconds: 50),
  }) async {
    final results = <T>[];
    final batches = _chunkList(items, batchSize);
    
    for (final batch in batches) {
      final batchResults = await Future.wait(
        batch.map((item) => processor(item)),
      );
      results.addAll(batchResults);
      
      // Small delay between batches to prevent UI blocking
      if (batches.last != batch) {
        await Future.delayed(batchDelay);
      }
    }
    
    return results;
  }

  /// Smart prefetching based on user behavior
  void smartPrefetch(String userAction, Map<String, dynamic> context) {
    switch (userAction) {
      case 'venue_scroll':
        _prefetchNextVenues(context['current_index'] ?? 0);
        break;
      case 'search_typing':
        _prefetchSearchSuggestions(context['query'] ?? '');
        break;
      case 'deal_view':
        _prefetchRelatedDeals(context['venue_id'] ?? '');
        break;
    }
  }

  /// Get optimization recommendations
  List<Map<String, dynamic>> getOptimizationRecommendations() {
    final recommendations = <Map<String, dynamic>>[];
    final analytics = getPerformanceAnalytics();
    
    // Check screen load times
    final screenLoadTimes = analytics['screen_load_times'];
    if (screenLoadTimes != null && screenLoadTimes['average'] > 1000) {
      recommendations.add({
        'type': 'performance',
        'title': 'Slow Screen Loading',
        'description': 'Average screen load time is ${screenLoadTimes['average'].toStringAsFixed(0)}ms',
        'recommendation': 'Consider enabling lazy loading and reducing initial data loads',
        'priority': 'high',
      });
    }
    
    // Check memory usage
    final memoryUsage = analytics['memory_usage'];
    if (memoryUsage != null && double.parse(memoryUsage['usage_percentage']) > 80) {
      recommendations.add({
        'type': 'memory',
        'title': 'High Memory Usage',
        'description': 'Memory usage is at ${memoryUsage['usage_percentage']}%',
        'recommendation': 'Clear image cache and optimize data storage',
        'priority': 'medium',
      });
    }
    
    // Check cache hit rate
    final cacheStats = analytics['cache_stats'];
    if (cacheStats != null && double.parse(cacheStats['image_cache_hit_rate']) < 0.7) {
      recommendations.add({
        'type': 'caching',
        'title': 'Low Cache Hit Rate',
        'description': 'Image cache hit rate is ${cacheStats['image_cache_hit_rate']}%',
        'recommendation': 'Increase cache size or adjust cache strategy',
        'priority': 'low',
      });
    }
    
    return recommendations;
  }

  /// Update optimization settings
  void updateOptimizationSettings(Map<String, dynamic> newSettings) {
    _optimizationSettings.addAll(newSettings);
  }

  Map<String, dynamic> getOptimizationSettings() {
    return Map.from(_optimizationSettings);
  }

  // Private helper methods

  void _startMemoryMonitoring() {
    Timer.periodic(const Duration(minutes: 1), (timer) {
      _updateMemoryUsage();
      optimizeMemoryUsage();
    });
  }

  void _startPerformanceMetricsCollection() {
    // Reset metrics daily to prevent unbounded growth
    Timer.periodic(const Duration(hours: 24), (timer) {
      _performanceMetrics.forEach((key, value) => value.clear());
    });
  }

  void _optimizeImageLoading() {
    // Configure image loading optimizations
    // This would integrate with Flutter's image loading system
  }

  void _updateMemoryUsage() {
    // Mock memory calculation - in real app would use dart:developer
    _currentMemoryUsage = _imageCache.length * 100000 + _dataCache.length * 50000;
  }

  void _performMemoryCleanup() {
    // Clear least recently used items
    _imageCache.clear();
    
    // Remove expired cache entries
    _cleanExpiredCache();
    
    // Force garbage collection hint
    if (kDebugMode) {
      print('Performed memory cleanup');
    }
  }

  void _cleanExpiredCache() {
    final expiredKeys = <String>[];
    final now = DateTime.now();
    
    for (final entry in _dataCache.entries) {
      if (entry.value.expiryTime.isBefore(now)) {
        expiredKeys.add(entry.key);
      }
    }
    
    for (final key in expiredKeys) {
      _dataCache.remove(key);
    }
  }

  void _keepMetricsWithinLimit(String metricName, {int maxEntries = 1000}) {
    final metrics = _performanceMetrics[metricName];
    if (metrics != null && metrics.length > maxEntries) {
      metrics.removeRange(0, metrics.length - maxEntries);
    }
  }

  Future<void> _preloadSingleVenue(String venueId) async {
    // Mock preload - would fetch venue data
    await Future.delayed(const Duration(milliseconds: 100));
    cacheVenueData(venueId, {'id': venueId, 'preloaded': true});
  }

  List<List<T>> _chunkList<T>(List<T> list, int chunkSize) {
    final chunks = <List<T>>[];
    for (int i = 0; i < list.length; i += chunkSize) {
      chunks.add(list.sublist(i, (i + chunkSize).clamp(0, list.length)));
    }
    return chunks;
  }

  void _preloadCriticalData() {
    // Preload essential app data
    Timer(const Duration(milliseconds: 100), () {
      // Mock critical data preloading
    });
  }

  void _initializeBackgroundServices() {
    // Initialize non-critical services in background
  }

  void _prefetchNextVenues(int currentIndex) {
    final prefetchCount = _optimizationSettings['preload_next_items'];
    // Mock prefetch logic
    for (int i = 1; i <= prefetchCount; i++) {
      final nextIndex = currentIndex + i;
      // Prefetch venue data for nextIndex
    }
  }

  void _prefetchSearchSuggestions(String query) {
    if (query.length >= 2) {
      // Mock search suggestion prefetch
    }
  }

  void _prefetchRelatedDeals(String venueId) {
    // Mock related deals prefetch
  }
}

