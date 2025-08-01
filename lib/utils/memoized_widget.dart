import 'package:flutter/material.dart';

/// Memoized widget to prevent unnecessary rebuilds
class MemoizedWidget<T> extends StatelessWidget {
  final T data;
  final Widget Function(T data) builder;
  final T? previousData;

  const MemoizedWidget({
    super.key,
    required this.data,
    required this.builder,
    this.previousData,
  });

  @override
  Widget build(BuildContext context) {
    return builder(data);
  }
}