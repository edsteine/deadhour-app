import 'package:deadhour/screens/utils/app_theme.dart';
import 'package:deadhour/screens/utils/performance_optimization_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


/// Performance monitoring widget for development and debugging
class PerformanceMonitorWidget extends StatefulWidget {
  final Widget child;
  final String screenName;
  final bool enableInProduction;

  const PerformanceMonitorWidget({
    super.key,
    required this.child,
    required this.screenName,
    this.enableInProduction = false,
  });

  @override
  State<PerformanceMonitorWidget> createState() => _PerformanceMonitorWidgetState();
}

class _PerformanceMonitorWidgetState extends State<PerformanceMonitorWidget> {
  final _performanceService = PerformanceOptimizationService();
  late final DateTime _startTime;
  bool _showOverlay = false;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    
    // Record screen load time when widget is fully built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final loadTime = DateTime.now().difference(_startTime).inMilliseconds;
      _performanceService.recordScreenLoadTime(widget.screenName, loadTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Only show performance overlay in debug mode or if explicitly enabled
    final shouldShowOverlay = (kDebugMode || widget.enableInProduction) && _showOverlay;

    return Stack(
      children: [
        widget.child,
        
        // Performance overlay
        if (shouldShowOverlay)
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 10,
            child: _buildPerformanceOverlay(),
          ),
        
        // Performance toggle button (debug only)
        if (kDebugMode)
          Positioned(
            bottom: 100,
            right: 10,
            child: _buildPerformanceToggle(),
          ),
      ],
    );
  }

  Widget _buildPerformanceOverlay() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.moroccoGreen),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.speed, color: Colors.white, size: 16),
              const SizedBox(width: 4),
              const Text(
                'Performance',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => setState(() => _showOverlay = false),
                child: const Icon(Icons.close, color: Colors.white, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 4),
          _buildPerformanceMetrics(),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
    final analytics = _performanceService.getPerformanceAnalytics();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildMetricRow('Screen', widget.screenName),
        if (analytics['screen_load_times'] != null)
          _buildMetricRow(
            'Load Time', 
            '${analytics['screen_load_times']['average'].toStringAsFixed(0)}ms'
          ),
        if (analytics['memory_usage'] != null)
          _buildMetricRow(
            'Memory', 
            '${analytics['memory_usage']['current_mb']}MB'
          ),
        if (analytics['cache_stats'] != null)
          _buildMetricRow(
            'Cache Hit', 
            '${(double.parse(analytics['cache_stats']['image_cache_hit_rate']) * 100).toStringAsFixed(0)}%'
          ),
        const SizedBox(height: 4),
        _buildRecommendationsButton(),
      ],
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 10,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationsButton() {
    return GestureDetector(
      onTap: () => _showRecommendationsDialog(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: AppTheme.moroccoGreen,
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Text(
          'Recommendations',
          style: TextStyle(
            color: Colors.white,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildPerformanceToggle() {
    return FloatingActionButton(
      heroTag: 'performance_monitor_fab',
      mini: true,
      backgroundColor: AppTheme.moroccoGreen,
      onPressed: () => setState(() => _showOverlay = !_showOverlay),
      child: Icon(
        _showOverlay ? Icons.speed_outlined : Icons.speed,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  void _showRecommendationsDialog() {
    final recommendations = _performanceService.getOptimizationRecommendations();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Performance Recommendations'),
        content: SizedBox(
          width: double.maxFinite,
          child: recommendations.isEmpty
              ? const Text('No recommendations at this time. Performance looks good!')
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: recommendations.length,
                  itemBuilder: (context, index) {
                    final rec = recommendations[index];
                    return Card(
                      child: ListTile(
                        leading: Icon(
                          _getRecommendationIcon(rec['type']),
                          color: _getRecommendationColor(rec['priority']),
                        ),
                        title: Text(
                          rec['title'],
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(rec['description']),
                            const SizedBox(height: 4),
                            Text(
                              rec['recommendation'],
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: _getRecommendationColor(rec['priority']),
                              ),
                            ),
                          ],
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getRecommendationColor(rec['priority']).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            rec['priority'].toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getRecommendationColor(rec['priority']),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          if (recommendations.isNotEmpty)
            ElevatedButton(
              onPressed: () {
                _performanceService.optimizeMemoryUsage();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Performance optimization applied')),
                );
              },
              child: const Text('Optimize Now'),
            ),
        ],
      ),
    );
  }

  IconData _getRecommendationIcon(String type) {
    switch (type) {
      case 'performance':
        return Icons.speed;
      case 'memory':
        return Icons.memory;
      case 'caching':
        return Icons.cached;
      default:
        return Icons.info;
    }
  }

  Color _getRecommendationColor(String priority) {
    switch (priority) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}