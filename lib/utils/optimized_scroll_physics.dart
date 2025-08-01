import 'package:flutter/material.dart';

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