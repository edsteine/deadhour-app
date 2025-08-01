import 'dart:collection';

/// LRU Cache implementation
class LRUCache<K, V> {
  final int maxSize;
  final LinkedHashMap<K, V> _cache = LinkedHashMap<K, V>();
  int _hits = 0;
  int _misses = 0;

  LRUCache({required this.maxSize});

  V? get(K key) {
    final value = _cache.remove(key);
    if (value != null) {
      _cache[key] = value; // Move to end (most recent)
      _hits++;
      return value;
    }
    _misses++;
    return null;
  }

  void put(K key, V value) {
    if (_cache.containsKey(key)) {
      _cache.remove(key);
    } else if (_cache.length >= maxSize) {
      _cache.remove(_cache.keys.first); // Remove least recent
    }
    _cache[key] = value;
  }

  void clear() {
    _cache.clear();
  }

  int get length => _cache.length;
  
  double get hitRate {
    final total = _hits + _misses;
    return total > 0 ? _hits / total : 0.0;
  }
}