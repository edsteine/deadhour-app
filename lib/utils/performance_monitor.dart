import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app_performance_service.dart';

// Performance monitoring widget
class PerformanceMonitor extends StatefulWidget {
  final Widget child;
  final bool enableMonitoring;

  const PerformanceMonitor({
    super.key,
    required this.child,
    this.enableMonitoring = kDebugMode,
  });

  @override
  State<PerformanceMonitor> createState() => _PerformanceMonitorState();
}

class _PerformanceMonitorState extends State<PerformanceMonitor> {
  late Timer _metricsTimer;
  Map<String, dynamic> _metrics = {};

  @override
  void initState() {
    super.initState();
    if (widget.enableMonitoring) {
      _startMetricsCollection();
    }
  }

  void _startMetricsCollection() {
    _metricsTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          _metrics = AppPerformanceService().getPerformanceMetrics();
        });
      }
    });
  }

  @override
  void dispose() {
    _metricsTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      textDirection: TextDirection.ltr,
      children: [
        widget.child,
        if (widget.enableMonitoring && kDebugMode)
          Positioned(
            top: 50,
            right: 10,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Performance',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Frames: ${_metrics['frameSkips'] ?? 0}',
                      style: const TextStyle(color: Colors.white, fontSize: 8),
                    ),
                    Text(
                      'Avg Frame: ${(_metrics['averageFrameTime'] ?? 0.0).toStringAsFixed(1)}ms',
                      style: const TextStyle(color: Colors.white, fontSize: 8),
                    ),
                    Text(
                      'Cache: ${_metrics['cacheSize'] ?? 0}',
                      style: const TextStyle(color: Colors.white, fontSize: 8),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}