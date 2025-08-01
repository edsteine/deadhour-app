import '../../utils/performance_optimization_service.dart';
import 'package:flutter/material.dart';

/// Lazy loading list view with performance optimization
class OptimizedListView extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final ScrollController? controller;
  final EdgeInsets? padding;
  final bool enableLazyLoading;

  const OptimizedListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.controller,
    this.padding,
    this.enableLazyLoading = true,
  });

  @override
  State<OptimizedListView> createState() => _OptimizedListViewState();
}

class _OptimizedListViewState extends State<OptimizedListView> {
  final _performanceService = PerformanceOptimizationService();
  late ScrollController _scrollController;
  final Set<int> _builtItems = {};

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
    
    if (widget.enableLazyLoading) {
      _scrollController.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    // Trigger smart prefetching based on scroll position
    if (_scrollController.hasClients) {
      final scrollOffset = _scrollController.offset;
      final maxScroll = _scrollController.position.maxScrollExtent;
      
      if (scrollOffset > maxScroll * 0.8) {
        _performanceService.smartPrefetch('venue_scroll', {
          'current_index': _builtItems.length,
          'scroll_position': scrollOffset,
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enableLazyLoading) {
      return ListView.builder(
        controller: _scrollController,
        padding: widget.padding,
        itemCount: widget.itemCount,
        itemBuilder: widget.itemBuilder,
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: widget.padding,
      itemCount: widget.itemCount,
      itemBuilder: (context, index) {
        _builtItems.add(index);
        
        // Use performance service to determine if item should render
        final shouldRender = _performanceService.shouldRenderItem(
          index,
          0, // Would calculate visible start in real implementation
          20, // Would calculate visible end in real implementation
          5, // Buffer size
        );

        if (!shouldRender) {
          return const SizedBox(height: 100); // Placeholder height
        }

        return widget.itemBuilder(context, index);
      },
    );
  }
}