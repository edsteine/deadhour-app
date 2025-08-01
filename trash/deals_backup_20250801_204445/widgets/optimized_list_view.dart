import 'package:flutter/material.dart';

/// Optimized ListView widget for better performance
class BasicOptimizedListView extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final EdgeInsetsGeometry? padding;

  const BasicOptimizedListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: padding,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      // Performance optimizations
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      addSemanticIndexes: false,
    );
  }
}