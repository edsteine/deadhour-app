import '../../utils/performance_optimization_service.dart';
import 'package:flutter/material.dart';

/// Performance-optimized image widget
class OptimizedImage extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const OptimizedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  });

  @override
  State<OptimizedImage> createState() => _OptimizedImageState();
}

class _OptimizedImageState extends State<OptimizedImage> {
  final _performanceService = PerformanceOptimizationService();
  late final DateTime _startTime;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    // Check cache first
    final cachedImage = _performanceService.getCachedImage(widget.imageUrl);
    if (cachedImage != null) {
      return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.imageUrl),
            fit: widget.fit,
          ),
        ),
      );
    }

    return Image.network(
      widget.imageUrl,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          // Image loaded, record timing and cache
          final loadTime = DateTime.now().difference(_startTime).inMilliseconds;
          _performanceService.recordImageLoadTime(loadTime);
          _performanceService.cacheImage(widget.imageUrl, child);
          return child;
        }
        
        return widget.placeholder ?? const Center(child: CircularProgressIndicator());
      },
      errorBuilder: (context, error, stackTrace) {
        return widget.errorWidget ?? Container(
          width: widget.width,
          height: widget.height,
          color: Colors.grey[300],
          child: const Icon(Icons.error),
        );
      },
    );
  }
}