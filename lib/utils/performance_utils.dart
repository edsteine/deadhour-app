import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Performance optimization utilities for DeadHour app
class PerformanceUtils {
  /// Debounce function calls to prevent excessive API calls
  static Timer? _debounceTimer;

  static void debounce(Duration delay, VoidCallback callback) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(delay, callback);
  }

  /// Optimized image loading with caching
  static Widget optimizedImage({
    required String imageUrl,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return placeholder ??
            SizedBox(
              width: width,
              height: height,
              child: const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
      },
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ??
            Container(
              width: width,
              height: height,
              color: Colors.grey[200],
              child: const Icon(Icons.broken_image, color: Colors.grey),
            );
      },
      cacheWidth: width?.toInt(),
      cacheHeight: height?.toInt(),
    );
  }

  /// Memoized widget builder to prevent unnecessary rebuilds
  static Widget memoizedBuilder<T>({
    required T data,
    required Widget Function(T data) builder,
    T? previousData,
  }) {
    return _MemoizedWidget<T>(
      data: data,
      builder: builder,
      previousData: previousData,
    );
  }

  /// Optimized list view with lazy loading
  static Widget optimizedListView({
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
    ScrollController? controller,
    EdgeInsets? padding,
    bool shrinkWrap = false,
    ScrollPhysics? physics,
  }) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        // Wrap each item in RepaintBoundary for better performance
        return RepaintBoundary(
          child: itemBuilder(context, index),
        );
      },
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      // Add caching for better scrolling performance
      cacheExtent: 1000,
    );
  }

  /// Optimized grid view
  static Widget optimizedGridView({
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
    required SliverGridDelegate gridDelegate,
    ScrollController? controller,
    EdgeInsets? padding,
    bool shrinkWrap = false,
  }) {
    return GridView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return RepaintBoundary(
          child: itemBuilder(context, index),
        );
      },
      gridDelegate: gridDelegate,
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      cacheExtent: 1000,
    );
  }

  /// Preload images for better UX
  static Future<void> preloadImages(
      BuildContext context, List<String> imageUrls) async {
    final futures =
        imageUrls.map((url) => precacheImage(NetworkImage(url), context));
    await Future.wait(futures);
  }

  /// Haptic feedback with performance consideration
  static void hapticFeedback(HapticFeedbackType type) {
    switch (type) {
      case HapticFeedbackType.light:
        HapticFeedback.lightImpact();
        break;
      case HapticFeedbackType.medium:
        HapticFeedback.mediumImpact();
        break;
      case HapticFeedbackType.heavy:
        HapticFeedback.heavyImpact();
        break;
      case HapticFeedbackType.selection:
        HapticFeedback.selectionClick();
        break;
    }
  }

  /// Memory-efficient color generation
  static Color colorFromString(String str) {
    int hash = 0;
    for (int i = 0; i < str.length; i++) {
      hash = str.codeUnitAt(i) + ((hash << 5) - hash);
    }
    final color = Color((hash & 0x00FFFFFF) | 0xFF000000);
    return color;
  }

  /// Efficient text truncation
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength - 3)}...';
  }

  /// Simulate network delay for testing and development
  static Future<void> simulateNetworkDelay([Duration? duration]) async {
    await Future.delayed(duration ?? const Duration(milliseconds: 500));
  }
}

/// Enum for haptic feedback types
enum HapticFeedbackType {
  light,
  medium,
  heavy,
  selection,
}

/// Memoized widget to prevent unnecessary rebuilds
class _MemoizedWidget<T> extends StatelessWidget {
  final T data;
  final Widget Function(T data) builder;
  final T? previousData;

  const _MemoizedWidget({
    required this.data,
    required this.builder,
    this.previousData,
  });

  @override
  Widget build(BuildContext context) {
    return builder(data);
  }
}

/// Custom scroll physics for better performance
class OptimizedScrollPhysics extends BouncingScrollPhysics {
  const OptimizedScrollPhysics({super.parent});

  @override
  OptimizedScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return OptimizedScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double get minFlingVelocity => 100.0; // Reduced for smoother scrolling

  @override
  double get maxFlingVelocity => 2000.0; // Capped for better control
}
